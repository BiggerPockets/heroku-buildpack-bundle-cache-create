#!/usr/bin/env bash

check_file_exists () {
  local aws_binary_path=$1
  local remote_path=$2
  local aws_bundle_cache_bucket=$(get_env_variable ${env_dir} "AWS_BUNDLE_CACHE_BUCKET")

  AWS_ACCESS_KEY_ID=$(get_env_variable ${env_dir} "AWS_ACCESS_KEY_ID") \
    AWS_SECRET_ACCESS_KEY=$(get_env_variable ${env_dir} "AWS_SECRET_ACCESS_KEY") \
    AWS_REGION=$(get_env_variable ${env_dir} "AWS_REGION") \
    $aws_binary_path s3api head-object --bucket "${aws_bundle_cache_bucket}" --key "${remote_path}" > /dev/null

  local status=$?

  if [[ status -eq 0 ]]; then
    echo "File ${remote_path} already exists in S3."
  else
    echo "File ${remote_path} does not exist in S3."
  fi

  return $status
}
