#!/bin/bash

# Ensure PROJECT_DIR is defined
if [ -z "$PROJECT_DIR" ]; then
  echo "Error: PROJECT_DIR environment variable is not set. Please refer to 0.Environment_Setup.md for setup instructions."
  exit 1
fi

# Create reads/ directory
mkdir "$PROJECT_DIR/Raw_reads"
cd "$PROJECT_DIR/Raw_reads"

#
