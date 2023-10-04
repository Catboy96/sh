#!/bin/bash

name=$1
repo=$2

mkdir /opt/elixir-data/$name

pushd /opt/elixir-data/$name
git clone $repo repo
mkdir data
popd

bash elixir-refresh.sh $name
chmod -R www-data /opt/elixir-data/$name
