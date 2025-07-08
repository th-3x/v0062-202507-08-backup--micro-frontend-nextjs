#!/bin/bash

# Function to fix dependencies in a specific directory
fix_dependencies() {
  local dir=$1
  echo "Fixing dependencies in $dir..."
  
  cd $dir
  npm uninstall next @module-federation/nextjs-mf webpack
  npm install next@13.4.19 @module-federation/nextjs-mf@7.0.8 webpack@5.88.2 --legacy-peer-deps
  cd ..
}

# Fix dependencies in all three applications
fix_dependencies "shell"
fix_dependencies "products"
fix_dependencies "profile"

echo "Dependencies have been fixed in all applications."
