# ✅ Demo Checklist - Verify Everything Works

## 🔍 Quick Status Check

Run this command to check all services:
```bash
node test-services.js
```

Or manually check:
- http://localhost:5000/health (Fingerprinting)
- http://localhost:3000/health (Backend)
- http://localhost:5173 (Frontend)

## 📋 What Should Be Running

### ✅ Terminal Windows (3 total)

1. **Terminal 1 - Fingerprinting Service**
   ```
   * Running on http://0.0.0.0:5000
   ```

2. **Terminal 2 - Backend API**
   ```
   🚀 Server running on port 3000
   ```

3. **Terminal 3 - Frontend**
   ```
   ➜  Local:   http://localhost:5173/
   ```

## 🎯 Test Each Feature

### Frontend Tests:
- [ ] Home page loads
- [ ] Navigation works (Marketplace, Upload, etc.)
- [ ] Model cards display
- [ ] No console errors
- [ ] Responsive design works

### Backend API Tests:
```bash
# Test health endpoint
curl http://localhost:3000/health

# Test models endpoint
curl http://localhost:3000/api/models

# Test search
curl http://localhost:3000/api/models/search/test
```

### Fingerprinting Service Tests:
```bash
# Test health endpoint
curl http://localhost:5000/health

# Test fingerprint generation
curl -X POST http://localhost:5000/api/fingerprint/generate \
  -H "Content-Type: application/json" \
  -d "{\"modelId\":1,\"modelData\":{\"framework\":\"pytorch\"}}"
```

## 🌐 Browser Access

**Main Application:**
http://localhost:5173

**API Endpoints:**
- Backend: http://localhost:3000/health
- Fingerprinting: http://localhost:5000/health

## 🎬 Demo Flow

1. **Open Frontend** → http://localhost:5173
2. **Browse Marketplace** → Click "Marketplace" in nav
3. **View Model** → Click any model card
4. **Try Upload** → Click "Upload Model" (requires wallet)
5. **Check API** → Open browser console, see API calls

## 🐛 Common Issues

### Services Not Starting?
- Check if ports are available
- Verify dependencies installed
- Check for error messages in terminals

### Frontend Not Loading?
- Check if backend is running
- Check browser console for errors
- Verify npm install completed

### API Errors?
- Check backend terminal for errors
- Verify database/Redis (optional for demo)
- Check CORS settings

## ✨ Success!

If you see:
- ✅ All 3 services running
- ✅ Frontend loads at localhost:5173
- ✅ No errors in terminals
- ✅ Can navigate pages

**Your demo is working! 🎉**

