#!/bin/bash

#######################################
# Runs all the exec.sh scripts in subdirectories
# Globals:
#   dir
# Arguments:
#  None
#######################################
function main() {
  for dir in $(find . -maxdepth 1 -type d); do
    if [ -f "$dir/exec.sh" ]; then
      echo "Running $dir/exec.sh"
      cd "$dir" && ./exec.sh && cd ..
    fi
  done
}

main "$@"

