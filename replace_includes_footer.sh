#!/bin/bash

# Define the path to the footer file and the SSI directive
FOOTER_FILE="layout/footer.html"
INCLUDE_DIRECTIVE="<!--#include virtual=\"layout/footer.html\"-->"

# Read the content of the footer file and escape special characters
FOOTER_CONTENT=$(< "$FOOTER_FILE")
FOOTER_CONTENT=$(printf '%s\n' "$FOOTER_CONTENT" | sed ':a;N;$!ba;s/\n/\\n/g')

# Replace SSI directive with footer content in all HTML files
find . -type f -name "*.html" | while read -r file; do
    awk -v footer="$FOOTER_CONTENT" -v directive="$INCLUDE_DIRECTIVE" '
        $0 ~ directive {
            print footer
        }
        $0 !~ directive {
            print
        }
    ' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
done
