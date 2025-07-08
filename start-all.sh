#!/bin/bash

# Function to kill processes using a specific port
kill_process_on_port() {
  local port=$1
  echo "Checking for processes on port $port..."
  
  # Find PID using the port
  local pid=$(ss -tulpn | grep ":$port" | awk '{print $7}' | sed 's/.*pid=\([0-9]*\).*/\1/')
  
  if [ ! -z "$pid" ]; then
    echo "Killing process $pid on port $port"
    kill -9 $pid
    sleep 1
  else
    echo "No process found on port $port"
  fi
}

# Kill any existing processes on our ports
kill_process_on_port 3000
kill_process_on_port 3002
kill_process_on_port 3003

# Clear Next.js cache
echo "Clearing Next.js cache..."
rm -rf ./shell/.next ./products/.next ./profile/.next

# Start the products app
echo "Starting products app on port 3003..."
cd products
npm run dev &
PRODUCTS_PID=$!
echo "Products app started with PID: $PRODUCTS_PID"
sleep 3

# Start the profile app
echo "Starting profile app on port 3002..."
cd ../profile
npm run dev &
PROFILE_PID=$!
echo "Profile app started with PID: $PROFILE_PID"
sleep 3

# Start the shell app
echo "Starting shell app on port 3000..."
cd ../shell
npm run dev &
SHELL_PID=$!
echo "Shell app started with PID: $SHELL_PID"

echo "All applications started. Access the shell app at http://localhost:3000"
echo "Press Ctrl+C to stop all applications"

# Wait for all processes
wait $PRODUCTS_PID $PROFILE_PID $SHELL_PID
