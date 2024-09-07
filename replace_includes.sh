#!/bin/bash

# Define the path to the header file and the SSI directive
HEADER_FILE="layout/header.html"
INCLUDE_DIRECTIVE="<!--#include virtual=\"layout/header.html\"-->"

# Read the content of the header file and escape special characters
HEADER_CONTENT=$(< "$HEADER_FILE")
HEADER_CONTENT=$(printf '%s\n' "$HEADER_CONTENT" | sed ':a;N;$!ba;s/\n/\\n/g')

# Replace SSI directive with header content in all HTML files
find . -type f -name "*.html" | while read -r file; do
    awk -v header="$HEADER_CONTENT" -v directive="$INCLUDE_DIRECTIVE" '
        $0 ~ directive {
            print header
        }
        $0 !~ directive {
            print
        }
    ' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
done