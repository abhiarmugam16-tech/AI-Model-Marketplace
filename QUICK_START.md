# Quick Start - Run Demo

## Step-by-Step Instructions

### Step 1: Start Fingerprinting Service

Open **Terminal 1** and run:
```bash
cd fingerprint-service
python src/app.py
```

You should see:
```
 * Running on http://0.0.0.0:5000
```

### Step 2: Start Backend API

Open **Terminal 2** and run:
```bash
cd backend
npm run dev
```

You should see:
```
🚀 Server running on port 3000
```

### Step 3: Start Frontend

Open **Terminal 3** and run:
```bash
cd frontend
npm run dev
```

You should see:
```
  VITE v5.x.x  ready in xxx ms
  ➜  Local:   http://localhost:5173/
```

## Access the Demo

1. **Frontend**: Open http://localhost:5173 in your browser
2. **Backend API**: http://localhost:3000/health
3. **Fingerprinting Service**: http://localhost:5000/health

## What You Can Test

✅ **Without Blockchain Setup:**
- Browse the UI
- View marketplace interface
- See model listings (mock data)
- Test frontend navigation

⚠️ **Requires Blockchain Setup:**
- Connect wallet
- Upload models
- Purchase licenses
- Full marketplace features

## Quick Test Commands

Test if services are running:

```bash
# Test fingerprinting service
curl http://localhost:5000/health

# Test backend
curl http://localhost:3000/health

# Or open in browser:
# http://localhost:5000/health
# http://localhost:3000/health
```

## Troubleshooting

**Port already in use?**
- Change PORT in .env files
- Or stop the service using that port

**Module not found?**
- Run `npm install` in backend/ and frontend/
- Run `pip install -r requirements.txt` in fingerprint-service/

**Database errors?**
- OK for basic demo - backend will run in limited mode
- See DEMO.md for full setup instructions

