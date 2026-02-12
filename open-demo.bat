@echo off
echo ========================================
echo Opening AI Model Marketplace Demo
echo ========================================
echo.

echo Waiting for services to start...
timeout /t 3 /nobreak >nul

echo.
echo Opening browser...
start http://localhost:5173

echo.
echo Opening API health checks...
start http://localhost:3000/health
start http://localhost:5000/health

echo.
echo ========================================
echo Demo URLs:
echo.
echo Frontend:    http://localhost:5173
echo Backend API: http://localhost:3000/health
echo Fingerprint: http://localhost:5000/health
echo ========================================
echo.
echo Make sure all services are running!
echo Check the terminal windows for status.
echo.
pause

