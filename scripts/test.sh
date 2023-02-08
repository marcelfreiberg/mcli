#!/bin/bash

MINIMUM_NODE_VERSION='12.0.0'

CURRENT_NODE_VERSION=$(node -v)
CURRENT_NODE_VERSION=${CURRENT_NODE_VERSION:1}

if [ "$CURRENT_NODE_VERSION" -ge "$MINIMUM_NODE_VERSION" ]; then
  :
else
  echo "Error: Current version of Node.js ($CURRENT_NODE_VERSION) does not fulfill the minimum required version $MINIMUM_NODE_VERSION"
  exit 1
fi
