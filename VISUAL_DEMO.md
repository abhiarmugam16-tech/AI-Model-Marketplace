#  Visual Demo Guide - What You Should See

##  Main Application (http://localhost:5173)

### Home Page
```
┌─────────────────────────────────────────────────┐
│  AI Model Marketplace    [Connect Wallet]      │
├─────────────────────────────────────────────────┤
│                                                 │
│         AI Model Marketplace                   │
│    Buy, sell, and verify AI models             │
│         on the blockchain                       │
│                                                 │
│    [Browse Marketplace]  [Upload Model]         │
│                                                 │
│  Featured Models                                │
│  ┌──────┐ ┌──────┐ ┌──────┐                   │
│  │Model │ │Model │ │Model │                   │
│  │Card  │ │Card  │ │Card  │                   │
│  └──────┘ └──────┘ └──────┘                   │
│                                                 │
└─────────────────────────────────────────────────┘
```

### Marketplace Page
```
┌─────────────────────────────────────────────────┐
│  Marketplace                                    │
├─────────────────────────────────────────────────┤
│  [Category ▼]  [Framework ▼]                   │
│                                                 │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐        │
│  │ Model 1  │ │ Model 2  │ │ Model 3 │        │
│  │          │ │          │ │          │        │
│  │ 0.5 ETH  │ │ 1.2 ETH  │ │ Free    │        │
│  └──────────┘ └──────────┘ └──────────┘        │
│                                                 │
└─────────────────────────────────────────────────┘
```

### Upload Page
```
┌─────────────────────────────────────────────────┐
│  Upload AI Model                                │
├─────────────────────────────────────────────────┤
│                                                 │
│  Model Name:     [________________]            │
│                                                 │
│  Description:    [________________]            │
│                  [________________]            │
│                                                 │
│  Category:      [Select ▼]                     │
│  Framework:      [Select ▼]                     │
│  License Type:   [Select ▼]                     │
│                                                 │
│  Model File:     [Choose File]                  │
│                                                 │
│              [Upload Model]                     │
│                                                 │
└─────────────────────────────────────────────────┘
```

##  API Health Checks

### Backend API (http://localhost:3000/health)
```json
{
  "status": "ok",
  "timestamp": "2024-01-XX...",
  "service": "AI Model Marketplace API"
}
```

### Fingerprinting Service (http://localhost:5000/health)
```json
{
  "status": "ok",
  "service": "Model Fingerprinting Service"
}
```

##  Success Indicators

### Terminal Windows Should Show:

**Terminal 1 - Fingerprinting:**
```
 * Running on http://0.0.0.0:5000
 * Debug mode: on
```

**Terminal 2 - Backend:**
```
 Web3 initialized
 IPFS client initialized
 Server running on port 3000
```

**Terminal 3 - Frontend:**
```
  VITE v5.x.x  ready in xxx ms
  ➜  Local:   http://localhost:5173/
```

##  Testing Checklist

- [ ] Open http://localhost:5173 → See home page
- [ ] Click "Marketplace" → See model listings
- [ ] Click "Upload Model" → See upload form
- [ ] Check browser console → No errors
- [ ] Test API → http://localhost:3000/health returns JSON
- [ ] Test fingerprinting → http://localhost:5000/health returns JSON

##  Browser Console (F12)

**Should see:**
- No red errors
- API calls to backend
- Web3 connection attempts (if wallet connected)

**Example API calls:**
```
GET http://localhost:3000/api/models
GET http://localhost:3000/api/models/search/...
```

##  UI Features to Test

1. **Navigation Bar**
   - Logo/Brand name
   - Links: Marketplace, Upload, My Models, My Licenses
   - Connect Wallet button

2. **Model Cards**
   - Model name
   - Description (truncated)
   - Price display
   - Framework badge
   - Clickable → Goes to detail page

3. **Responsive Design**
   - Resize browser window
   - Should adapt to mobile/tablet/desktop
   - Navigation should work on all sizes

##  Common Issues & Solutions

### Frontend Shows "Cannot connect to backend"
-  Check backend is running (Terminal 2)
-  Check http://localhost:3000/health works
-  Check CORS settings in backend

### Blank Page
-  Check browser console for errors
-  Verify npm install completed
-  Check if port 5173 is available

### API Returns 404
-  Check route exists in backend
-  Verify API URL is correct
-  Check backend logs for errors

##  Demo Success!

**You'll know it's working when:**
-  All 3 services show "Running" in status page
-  Frontend loads without errors
-  Can navigate between pages
-  API endpoints return data
-  UI looks professional and responsive

---

**Open `demo-status.html` in browser for live status dashboard!**

