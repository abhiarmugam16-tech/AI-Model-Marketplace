#!/bin/bash

echo "========================================"
echo "AI Model Marketplace - Demo Startup"
echo "========================================"
echo ""

echo "Starting services..."
echo ""

# Start Fingerprinting Service
echo "[1/3] Starting Fingerprinting Service (Port 5000)..."
cd fingerprint-service
python src/app.py &
FINGERPRINT_PID=$!
cd ..

sleep 2

# Start Backend API
echo "[2/3] Starting Backend API (Port 3000)..."
cd backend
npm run dev &
BACKEND_PID=$!
cd ..

sleep 2

# Start Frontend
echo "[3/3] Starting Frontend (Port 5173)..."
cd frontend
npm run dev &
FRONTEND_PID=$!
cd ..

echo ""
echo "========================================"
echo "All services are starting!"
echo ""
echo "Fingerprinting Service: http://localhost:5000"
echo "Backend API: http://localhost:3000"
echo "Frontend: http://localhost:5173"
echo ""
echo "Note: Make sure PostgreSQL and Redis are running"
echo "      if you want full functionality."
echo ""
echo "Press Ctrl+C to stop all services"
echo "========================================"

# Wait for user interrupt
trap "kill $FINGERPRINT_PID $BACKEND_PID $FRONTEND_PID; exit" INT
wait

