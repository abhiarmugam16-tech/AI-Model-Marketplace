# 🎬 AI Model Marketplace - Live Demo Guide

## 🚀 Starting the Demo

### Step 1: Start Fingerprinting Service

Open **PowerShell/Terminal 1**:
```powershell
cd fingerprint-service
python src/app.py
```

**Expected Output:**
```
 * Running on http://0.0.0.0:5000
 * Debug mode: on
```

**Test it:** Open http://localhost:5000/health in browser
Should show: `{"status":"ok","service":"Model Fingerprinting Service"}`

---

### Step 2: Start Backend API

Open **PowerShell/Terminal 2**:
```powershell
cd backend
npm run dev
```

**Expected Output:**
```
✅ Database connected (or warning if not set up)
✅ Redis connected (or warning if not set up)
✅ Web3 initialized
✅ IPFS client initialized
🚀 Server running on port 3000
```

**Test it:** Open http://localhost:3000/health in browser
Should show: `{"status":"ok","timestamp":"...","service":"AI Model Marketplace API"}`

---

### Step 3: Start Frontend

Open **PowerShell/Terminal 3**:
```powershell
cd frontend
npm run dev
```

**Expected Output:**
```
  VITE v5.x.x  ready in xxx ms

  ➜  Local:   http://localhost:5173/
  ➜  Network: use --host to expose
```

**Open in Browser:** http://localhost:5173

---

## 🎯 What You'll See

### Frontend Pages:

1. **Home Page** (`/`)
   - Welcome message
   - Featured models section
   - Browse and Upload buttons

2. **Marketplace** (`/marketplace`)
   - Grid of model cards
   - Filter options (Category, Framework)
   - Model listings

3. **Upload Model** (`/upload`)
   - Form to upload AI models
   - Requires wallet connection
   - Model metadata fields

4. **Model Detail** (`/model/:id`)
   - Model information
   - Purchase button
   - Model specifications

5. **My Models** (`/my-models`)
   - User's uploaded models
   - Management interface

6. **My Licenses** (`/my-licenses`)
   - Purchased licenses
   - License details

---

## 🧪 Testing the API

### Test Fingerprinting Service:

```bash
# Health check
curl http://localhost:5000/health

# Generate fingerprint
curl -X POST http://localhost:5000/api/fingerprint/generate \
  -H "Content-Type: application/json" \
  -d '{"modelId": 1, "modelData": {"framework": "pytorch"}}'
```

### Test Backend API:

```bash
# Health check
curl http://localhost:3000/health

# Get models
curl http://localhost:3000/api/models

# Search models
curl http://localhost:3000/api/models/search/test
```

---

## 📸 Expected UI Screenshots Description

### Home Page
- **Header**: "AI Model Marketplace" title
- **Navigation**: Marketplace, Upload, My Models, My Licenses
- **Hero Section**: Large title "AI Model Marketplace" with description
- **Buttons**: "Browse Marketplace" and "Upload Model"
- **Featured Models**: Grid of 6 model cards

### Marketplace Page
- **Page Title**: "Marketplace"
- **Filters**: Dropdowns for Category and Framework
- **Model Grid**: Cards showing:
  - Model name
  - Description (truncated)
  - Price in ETH
  - Framework badge

### Upload Page
- **Page Title**: "Upload AI Model"
- **Form Fields**:
  - Model Name (text input)
  - Description (textarea)
  - Category (dropdown)
  - Framework (dropdown)
  - License Type (dropdown)
  - Model File (file input)
- **Submit Button**: "Upload Model"

---

## 🔧 Troubleshooting

### Service Won't Start?

**Fingerprinting Service:**
```bash
# Check if Python is installed
python --version

# Install dependencies
pip install flask flask-cors numpy requests python-dotenv pydantic
```

**Backend:**
```bash
# Check Node.js
node --version

# Install dependencies
cd backend
npm install

# Check for errors
npm run dev
```

**Frontend:**
```bash
# Install dependencies
cd frontend
npm install

# Check for errors
npm run dev
```

### Port Already in Use?

Change ports in:
- `fingerprint-service/src/app.py` - Change `port = 5000`
- `backend/.env` - Change `PORT=3000`
- `frontend/vite.config.js` - Change `port: 5173`

---

## ✅ Verification Checklist

- [ ] Fingerprinting service responds at http://localhost:5000/health
- [ ] Backend API responds at http://localhost:3000/health
- [ ] Frontend loads at http://localhost:5173
- [ ] Can navigate between pages
- [ ] UI displays correctly
- [ ] No console errors in browser

---

## 🎉 Success Indicators

✅ **All Services Running:**
- 3 terminal windows showing running services
- No error messages
- Health endpoints return OK

✅ **Frontend Working:**
- Page loads without errors
- Navigation works
- UI displays correctly
- Responsive design works

✅ **API Working:**
- Health checks return JSON
- CORS enabled (frontend can call backend)
- Routes respond correctly

---

## 📝 Next Steps

Once demo is running:

1. **Explore the UI** - Navigate all pages
2. **Test API endpoints** - Use browser dev tools or curl
3. **Connect Wallet** - Install MetaMask and connect (for blockchain features)
4. **Set up Database** - For full functionality (see DEPLOYMENT.md)
5. **Deploy Contracts** - For blockchain features (see DEPLOYMENT.md)

---

**Need Help?** Check `QUICK_START.md` or `DEPLOYMENT.md` for detailed setup instructions.

