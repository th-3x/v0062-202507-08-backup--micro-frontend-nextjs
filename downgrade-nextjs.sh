#!/bin/bash

# Function to downgrade Next.js in a specific directory
downgrade_nextjs() {
  local dir=$1
  echo "Downgrading Next.js in $dir..."
  
  cd $dir
  npm uninstall next @module-federation/nextjs-mf
  npm install next@13.4.19 @module-federation/nextjs-mf@6.7.1 --legacy-peer-deps
  cd ..
}

# Downgrade Next.js in all three applications
downgrade_nextjs "shell"
downgrade_nextjs "products"
downgrade_nextjs "profile"

echo "Next.js has been downgraded to version 13.4.19 in all applications."
echo "Module Federation plugin has been downgraded to version 6.7.1."
