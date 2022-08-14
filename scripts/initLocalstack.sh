#!/bin/bash

## Creates the bucket
aws --endpoint-url="http://localhost:4566" s3 mb s3://rs-chat-local

## Clear all and remove bucket
# aws --endpoint-url="http://localhost:4566" s3 rb s3://rs-chat-local --force

## List all the files in the bucket
# aws --endpoint-url="http://localhost:4566" s3 ls s3://rs-chat-local --recursive
