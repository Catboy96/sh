#!/bin/bash

proj=$1

[ ! -d /opt/elixir-data/$proj/repo ] && echo "Invalid project $1" && exit 1

git config --global --add safe.directory /opt/elixir-data/$proj/repo
chown -R www-data /opt/elixir-data/$proj

echo "Start handling project $proj"

export LXR_REPO_DIR=/opt/elixir-data/$proj/repo
export LXR_DATA_DIR=/opt/elixir-data/$proj/data

pushd /usr/local/elixir/

echo "List tag of project $proj"
./script.sh list-tags

echo "Building index of project $proj"
./update.py 16

popd
