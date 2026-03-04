#!/bin/bash

SRC="$HOME/notes-site/src"
OUT="$HOME/notes-site/output"
TEMPLATE="$HOME/notes-site/theme/template.html"

# clean output
rm -rf "$OUT"
mkdir -p "$OUT"

# manual order
ORDER=(
    "README"
    "vim"
    "mds"
    "git"
    "i3"
    "C++"
    "arithmetic"
    "warbird"
)

# convert each markdown file in order
for name in "${ORDER[@]}"; do
    f="$SRC/$name.md"
    
    # skip if file doesn't exist
    [ -f "$f" ] || continue
    
    title=$(head -1 "$f" | sed 's/# //')
    
    # convert markdown to HTML with pandoc
    content=$(pandoc "$f" --from markdown --to html)
    
    # build active nav
    ACTIVE_NAV=""
    for n in "${ORDER[@]}"; do
        fn="$SRC/$n.md"
        [ -f "$fn" ] || continue
        t=$(head -1 "$fn" | sed 's/# //')
        if [ "$n" = "$name" ]; then
            ACTIVE_NAV="$ACTIVE_NAV<a href=\"$n.html\" class=\"active\">$t</a>\n"
        else
            ACTIVE_NAV="$ACTIVE_NAV<a href=\"$n.html\">$t</a>\n"
        fi
    done
    
    # inject into template
    html=$(cat "$TEMPLATE")
    html="${html/TITLE_PLACEHOLDER/$title}"
    html="${html/NAV_PLACEHOLDER/$ACTIVE_NAV}"
    html="${html/CONTENT_PLACEHOLDER/$content}"
    
    echo "$html" > "$OUT/$name.html"
    echo "built: $name.html"
done

# set index
cp "$OUT/README.html" "$OUT/index.html"

echo "done. output in $OUT/"
