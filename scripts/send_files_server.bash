#!/bin/bash

function send() {
  local host
  local remote_dir
  local directories=(
    ""
  )
  local directory

  host="$1"
  remote_dir="$2"

  for directory in "${directories[@]}"; do
    if [ -d "$directory" ]; then
      echo "Sending $directory to $host:$remote_dir"
      scp -r "$directory" "$host:$remote_dir"
    else
      echo "Directory $directory does not exist"
    fi
  done
}

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <host> <remote_dir>"
  exit 1
fi

send "$@"
