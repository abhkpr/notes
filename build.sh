#!/bin/bash

SRC="$HOME/notes-site/src"
OUT="$HOME/notes-site/output"
TEMPLATE="$HOME/notes-site/theme/template.html"

rm -rf "$OUT"
mkdir -p "$OUT"

ORDER=(
    "README"
    "how-to-build"
    "linux"
    "vim"
    "mds"
    "git"
    "i3"
    "C++"
    "arithmetic"
    "html"
    "css"
    "js"
    "py"
    "kt"
    "vocab"
    "cs"
    "database"
    "network"
    "system-design"
    "web"
    "warbird"
)

# build nav links file
NAV_FILE=$(mktemp)

for name in "${ORDER[@]}"; do
    f="$SRC/$name.md"
    [ -f "$f" ] || continue
    title=$(head -1 "$f" | sed 's/# //')
    echo "$name|$title" >> "$NAV_FILE"
done

# convert each file
for name in "${ORDER[@]}"; do
    f="$SRC/$name.md"
    [ -f "$f" ] || continue

    title=$(head -1 "$f" | sed 's/# //')
    content=$(pandoc "$f" --from markdown --to html)

    # build nav html
    nav=""
    while IFS='|' read -r n t; do
        if [ "$n" = "$name" ]; then
            nav="$nav<a href=\"$n.html\" class=\"active\">$t</a>"
        else
            nav="$nav<a href=\"$n.html\">$t</a>"
        fi
    done < "$NAV_FILE"

    # use python for safe substitution
    python3 - <<EOF
with open("$TEMPLATE", "r") as f:
    html = f.read()

title = """$title"""
nav = """$nav"""
content = """$content"""

html = html.replace("TITLE_PLACEHOLDER", title)
html = html.replace("NAV_PLACEHOLDER", nav)
html = html.replace("CONTENT_PLACEHOLDER", content)

with open("$OUT/$name.html", "w") as f:
    f.write(html)

print("built: $name.html")
EOF

done

rm "$NAV_FILE"
cp "$OUT/README.html" "$OUT/index.html"
echo "done."
