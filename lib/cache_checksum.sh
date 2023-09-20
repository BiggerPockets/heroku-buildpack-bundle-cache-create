#!/usr/bin/env bash

cache_checksum () {
  files_to_checksum=(
    "$build_dir/Gemfile.lock"
    "$build_dir/yarn.lock"
    "$build_dir/.node_version"
    "$build_dir/.ruby-version"
    "$build_dir/app.json"
  )

  checksum=""

  for file in "${files_to_checksum[@]}"; do
    checksum="${checksum}$(md5sum "$file" | cut -c1-32)"
  done

  echo "$checksum"
}
