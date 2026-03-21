#!/bin/bash

SRC="$HOME/notes-site/src"
OUT="$HOME/notes-site/output"
TEMPLATE="$HOME/notes-site/theme/template.html"

rm -rf "$OUT"
mkdir -p "$OUT"

ORDER=(
    "README"

    # foundations
    "linux"
    "alacritty"
    "bash"
    "vim"
    "mds"
    "git"
    "git-workflow"
    "gh"
    "gh-cli-wf"
    "i3"

    # math and cs theory
    "arithmetic"
    "dsa"
    "cs"
    "system-design"
    "design-pattern"

    #CP
    "Cpp"

    # web frontend
    "html"
    "css"
    "js"
    "ts"
    "tailwind"
    "react"
    "nextjs"

    # backend and data
    "py"
    "api"
    "sql"
    "database"
    "network"
    "security"
    "cloudflare"
    "deploy"
    "docker"
    "testing"

    # mobile
    "kt"

    # putting it all together
    "fullstack"
    "how-to-build"
    "design"
    "web"
    "vocab"

    # personal
    "warbird"
    "research"
)

# build nav links file
NAV_FILE=$(mktemp)

for name in "${ORDER[@]}"; do
    f="$SRC/$name.md"
    [ -f "$f" ] || continue
    title=$(head -1 "$f" | sed 's/# //')
    echo "$name|$title" >> "$NAV_FILE"
done

# ── BUILD SEARCH INDEX ──
# Write all src paths + names to a temp file, then process in one python call
SEARCH_INDEX="$OUT/search-index.json"
INDEX_INPUT=$(mktemp)

for name in "${ORDER[@]}"; do
    f="$SRC/$name.md"
    [ -f "$f" ] || continue
    page_title=$(head -1 "$f" | sed 's/# //')
    echo "$f|$name|$page_title" >> "$INDEX_INPUT"
done

python3 - "$INDEX_INPUT" "$SEARCH_INDEX" <<'IDXEOF'
import sys, json, re

input_path, out_path = sys.argv[1], sys.argv[2]
entries = []

with open(input_path) as fh:
    files = [l.strip() for l in fh if l.strip()]

for line in files:
    filepath, name, page_title = line.split('|', 2)

    try:
        with open(filepath, encoding='utf-8', errors='replace') as fh:
            lines = fh.readlines()
    except:
        continue

    current_heading = page_title
    current_body_lines = []

    def flush(heading, body_lines):
        body = ' '.join(
            re.sub(r'[`*_#\[\]()>]', '', l.strip())
            for l in body_lines
            if l.strip() and not l.strip().startswith('```')
        ).strip()[:200]
        if heading or body:
            entries.append({
                "title": heading or page_title,
                "page":  page_title,
                "href":  name + ".html",
                "body":  body
            })

    for line in lines:
        hm = re.match(r'^(#{1,3})\s+(.*)', line)
        if hm:
            flush(current_heading, current_body_lines)
            current_heading = hm.group(2).strip()
            current_body_lines = []
        else:
            current_body_lines.append(line)
    flush(current_heading, current_body_lines)

with open(out_path, 'w') as f:
    json.dump(entries, f, ensure_ascii=False)

print(f"search index: {len(entries)} entries → search-index.json")
IDXEOF

rm "$INDEX_INPUT"

# ── CONVERT EACH FILE ──
for name in "${ORDER[@]}"; do
    f="$SRC/$name.md"
    [ -f "$f" ] || continue

    title=$(head -1 "$f" | sed 's/# //')

    # build nav html
    nav=""
    while IFS='|' read -r n t; do
        if [ "$n" = "$name" ]; then
            nav="$nav<a href=\"$n.html\" class=\"active\">$t</a>"
        else
            nav="$nav<a href=\"$n.html\">$t</a>"
        fi
    done < "$NAV_FILE"

    # write to temp files — avoids bash mangling special chars in heredoc
    TITLE_FILE=$(mktemp)
    NAV_TMP=$(mktemp)
    CONTENT_FILE=$(mktemp)

    echo "$title" > "$TITLE_FILE"
    echo "$nav"   > "$NAV_TMP"
    pandoc "$f" --from markdown --to html > "$CONTENT_FILE"

    python3 - "$TEMPLATE" "$TITLE_FILE" "$NAV_TMP" "$CONTENT_FILE" "$OUT/$name.html" <<'PYEOF'
import sys

template_path, title_path, nav_path, content_path, out_path = sys.argv[1:]

with open(template_path)  as f: html    = f.read()
with open(title_path)     as f: title   = f.read().strip()
with open(nav_path)       as f: nav     = f.read().strip()
with open(content_path)   as f: content = f.read()

html = html.replace("TITLE_PLACEHOLDER",   title)
html = html.replace("NAV_PLACEHOLDER",     nav)
html = html.replace("CONTENT_PLACEHOLDER", content)

with open(out_path, "w") as f:
    f.write(html)

print(f"built: {out_path.split('/')[-1]}")
PYEOF

    rm "$TITLE_FILE" "$NAV_TMP" "$CONTENT_FILE"

done

rm "$NAV_FILE"
cp "$OUT/README.html" "$OUT/index.html"
echo "done."
