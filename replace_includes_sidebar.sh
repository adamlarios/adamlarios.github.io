#!/bin/bash

# Define the path to the sidebar file and the SSI directive
SIDEBAR_FILE="layout/sidebar.html"
INCLUDE_DIRECTIVE="<!--#include virtual=\"layout/sidebar.html\"-->"

# Read the content of the sidebar file and escape special characters
SIDEBAR_CONTENT=$(< "$SIDEBAR_FILE")
SIDEBAR_CONTENT=$(printf '%s\n' "$SIDEBAR_CONTENT" | sed ':a;N;$!ba;s/\n/\\n/g')

# Replace SSI directive with sidebar content in all HTML files
find . -type f -name "*.html" | while read -r file; do
    awk -v sidebar="$SIDEBAR_CONTENT" -v directive="$INCLUDE_DIRECTIVE" '
        $0 ~ directive {
            print sidebar
        }
        $0 !~ directive {
            print
        }
    ' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
done
