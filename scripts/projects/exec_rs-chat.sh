#!/bin/bash

#######################################
# Kills the process with the given port
# Arguments:
#   port number of the process to kill
#######################################
function kill_process_at_port() {
  local port=$1
  local pid
  pid=$(lsof -i:"$port" | grep LISTEN | awk '{print $2}')
  if [ -n "$pid" ]; then
    kill -TERM "$pid"
  fi
}

#######################################
# Builds the application
# Arguments:
#  None
#######################################
function build() {
  mvn clean package -DskipTests
}

#######################################
# Executes the jar of the application
# Arguments:
#  Folder where the jar is located
#######################################
function run_application_jar() {
  cd "$1" && java -jar target/rs-chat-backend-0.0.1.jar &> /dev/null &
}

#######################################
# Exports the environment variables needed for the application
# Globals:
#   line
# Arguments:
#   1 - The file to be exported
#######################################
function export_env() {
  # Read the corresponding env file and export the variables
  while read -r line; do
    export $line &> /dev/null
  done < .env."$1"
}

#######################################
# Creates the S3 bucket to store files.
# Globals:
#   AWS_S3_BUCKET_NAME
# Arguments:
#  None
#######################################
function create_s3_bucket() {
  # Check that localstack is running
  if ! curl -s http://localhost:4566/health | grep -q "available"; then
    echo "Localstack is not running"
    exit 1
  fi

  # Create the S3 bucket if it doesn't exist
  aws s3api head-bucket --bucket "$AWS_S3_BUCKET_NAME" 2> /dev/null || aws --endpoint-url=http://localhost:4566 s3 mb s3://"$AWS_S3_BUCKET_NAME"
}

#######################################
# Runs the specified environment of the application
# Globals:
#   PORT
# Arguments:
#   The folder of the env to run
#######################################
function run_env() {
  echo "Running $1 environment"
  cd "$1" && git pull && build && export_env "$1" && cd ..
  create_s3_bucket
  kill_process_at_port "$PORT"
  run_application_jar "$1"
}

#######################################
# Main function
# Globals:
#   command
# Arguments:
#  None
#######################################
function main() {
  echo 'You are starting the application'
  echo 'Possible commands:'
  echo '  1) Deploy to development environment'
  echo '  2) Deploy to production environment'
  echo '  3) Deploy to all environments'

  local command
  read -rp 'Enter the command number: ' command

  case $command in
    1)
      run_env dev &> /dev/null &
      ;;
    2)
      run_env prod &> /dev/null &
      ;;
    3)
      run_env dev &> /dev/null &
      run_env prod &> /dev/null &
      ;;
    *)
      echo 'Invalid command'
      ;;
  esac

}

main "$@"

