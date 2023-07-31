#!/bin/bash

# Brief description of your script
# Copyright 2023 samuel

function main() {
  # The directory we want to start from
  local dir='path/for/the/files'

  # The text we want to insert at the beginning of each file
  local text="<text to add to the first line"

  # Using find command to locate all files then using sed to insert the text
  find "$dir" -type f -exec sed -i "1i $text" {} \;
}

main "$@"
