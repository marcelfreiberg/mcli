#!/bin/bash

NGINX_WEB_DIR='/var/www/html'
REPO_URI='https://github.com/marcelfreiberg/marcelfreiberg.com'
REPO_OUT="$HOME/.marcellocli/marcelfreiberg.com"

echo "--Checking if git and node are installed..."
# Check if git, npm and node are installed
if ! [ -x "$(command -v git)" ]; then
  echo '--Error: git is not installed.' >&2
  exit 1
fi

if ! [ -x "$(command -v node)" ]; then
  echo '--Error: node is not installed.' >&2
  exit 1
fi

if ! [ -x "$(command -v npm)" ]; then
  echo '--Error: npm is not installed.' >&2
  exit 1
fi

echo "--Removing previous files in the repository directory if it exists..."
# Remove previous files in the repository directory if it exists
if [ -d ""$REPO_OUT"" ]; then
  rm -rf "$REPO_OUT"
fi

echo "--Cloning the repository into website directory"
# Clone the repository
git clone --depth 1 "$REPO_URI" "$REPO_OUT"
if [ $? -ne 0 ]; then
  echo "--Error: Failed to clone repository" >&2
  exit 1
fi

# Go into the repository
cd "$REPO_OUT"

echo "--Building the project with yarn"
# Build the project with yarn
yarn install
if [ $? -ne 0 ]; then
  echo "--Error: yarn install failed" >&2
  exit 1
fi

yarn run build
if [ $? -ne 0 ]; then
  echo "--Error: yarn run build failed" >&2
  exit 1
fi

# # Check if the nginx web directory exists
# if [ -d "$NGINX_WEB_DIR" ]; then
#   # Remove previous files in the nginx web directory
#   rm -rf "$NGINX_WEB_DIR"/*
# else
#   echo "--Error: $NGINX_WEB_DIR does not exist" >&2
#   exit 1
# fi

# echo "--Copying the output to the nginx web directory"
# # Copy the output to the nginx web directory
# cp -r ./.next/static/* "$NGINX_WEB_DIR"/

echo "--Script executed successfully!"
