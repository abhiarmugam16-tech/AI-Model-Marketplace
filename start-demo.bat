@echo off
echo ========================================
echo AI Model Marketplace - Demo Startup
echo ========================================
echo.

echo Starting services...
echo.

echo [1/3] Starting Fingerprinting Service (Port 5000)...
start "Fingerprinting Service" cmd /k "cd fingerprint-service && python src/app.py"

timeout /t 3 /nobreak >nul

echo [2/3] Starting Backend API (Port 3000)...
start "Backend API" cmd /k "cd backend && npm run dev"

timeout /t 3 /nobreak >nul

echo [3/3] Starting Frontend (Port 5173)...
start "Frontend" cmd /k "cd frontend && npm run dev"

timeout /t 3 /nobreak >nul

echo.
echo ========================================
echo All services are starting!
echo.
echo Fingerprinting Service: http://localhost:5000
echo Backend API: http://localhost:3000
echo Frontend: http://localhost:5173
echo.
echo Note: Make sure PostgreSQL and Redis are running
echo       if you want full functionality.
echo ========================================
pause

