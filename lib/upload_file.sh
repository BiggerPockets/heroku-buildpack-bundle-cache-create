#!/usr/bin/env bash

upload_file () {
  local aws_binary_path=$1
  local local_path=$2
  local remote_path=$3
  local aws_bundle_cache_bucket=$(get_env_variable ${env_dir} "AWS_BUNDLE_CACHE_BUCKET")

  AWS_ACCESS_KEY_ID=$(get_env_variable ${env_dir} "AWS_ACCESS_KEY_ID") \
    AWS_SECRET_ACCESS_KEY=$(get_env_variable ${env_dir} "AWS_SECRET_ACCESS_KEY") \
    AWS_REGION=$(get_env_variable ${env_dir} "AWS_REGION") \
    $aws_binary_path s3 cp $local_path s3://${aws_bundle_cache_bucket}/$remote_path --quiet

  local status=$?

  if [[ status -eq 0 ]]; then
    echo "Uploaded local $local_path to s3://${aws_bundle_cache_bucket}/$remote_path" | indent
  fi

  return $status
}
