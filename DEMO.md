# Quick Demo Guide

## Prerequisites Check

Before running the demo, ensure you have:

- ✅ Node.js installed
- ✅ Python installed
- ⚠️ PostgreSQL (optional for basic demo)
- ⚠️ Redis (optional for basic demo)
- ⚠️ IPFS node or use public gateway

## Quick Start (Minimal Setup)

### Option 1: Use the Startup Script (Windows)

```bash
start-demo.bat
```

### Option 2: Manual Start

#### Terminal 1: Fingerprinting Service
```bash
cd fingerprint-service
python src/app.py
```
Service runs on: http://localhost:5000

#### Terminal 2: Backend API
```bash
cd backend
npm run dev
```
Service runs on: http://localhost:3000

#### Terminal 3: Frontend
```bash
cd frontend
npm run dev
```
Service runs on: http://localhost:5173

## Testing the Demo

### 1. Check Services are Running

- Fingerprinting: http://localhost:5000/health
- Backend: http://localhost:3000/health
- Frontend: http://localhost:5173

### 2. Test Fingerprinting Service

```bash
curl http://localhost:5000/health
```

### 3. Test Backend API

```bash
curl http://localhost:3000/health
```

### 4. Access Frontend

Open browser to: http://localhost:5173

## Demo Features to Test

1. **Connect Wallet** - Click "Connect Wallet" button (requires MetaMask)
2. **Browse Marketplace** - View available models
3. **Upload Model** - Upload a test AI model file
4. **View Model Details** - Click on any model card

## Troubleshooting

### Backend won't start
- Check if port 3000 is available
- Ensure .env file is configured (can use defaults for demo)
- Database connection errors are OK for basic demo

### Frontend won't start
- Check if port 5173 is available
- Ensure backend is running first

### Fingerprinting service won't start
- Check if port 5000 is available
- Ensure Python dependencies are installed

## Note

For a full demo with blockchain features:
1. Deploy contracts to local Hardhat node or testnet
2. Configure contract addresses in backend/.env
3. Set up PostgreSQL database
4. Set up Redis for caching

For basic UI demo, the frontend will work but blockchain features will be limited.

