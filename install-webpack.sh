#!/bin/bash

# Function to install webpack in a specific directory
install_webpack() {
  local dir=$1
  echo "Installing webpack in $dir..."
  
  cd $dir
  npm install webpack@5.88.2 --legacy-peer-deps
  cd ..
}

# Install webpack in all three applications
install_webpack "shell"
install_webpack "products"
install_webpack "profile"

echo "Webpack has been installed in all applications."
