# AI Model Marketplace on Blockchain

A secure decentralized marketplace where AI models can be uploaded, verified, licensed, and sold — while preventing model theft and ensuring ownership transparency.

##  Features

- **Model Registration**: Upload AI models with blockchain-based ownership
- **Fingerprinting**: Advanced model fingerprinting to prevent plagiarism
- **Marketplace**: Buy and sell AI models with smart contracts
- **License Management**: Purchase and manage model licenses
- **Verification**: Automated model verification and authenticity checks
- **IPFS Storage**: Decentralized storage for model files
- **Royalty System**: Automatic royalty distribution to creators

##  Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     BLOCKCHAIN LAYER                         │
│  (Smart Contracts: Registry, Marketplace, Verification)    │
└─────────────────────────────────────────────────────────────┘
                            ↕
┌─────────────────────────────────────────────────────────────┐
│                   DECENTRALIZED STORAGE                      │
│              (IPFS - Model files & metadata)                 │
└─────────────────────────────────────────────────────────────┘
                            ↕
┌─────────────────────────────────────────────────────────────┐
│                    BACKEND API (Node.js)                     │
│        (Express, Web3, IPFS, PostgreSQL, Redis)            │
└─────────────────────────────────────────────────────────────┘
                            ↕
┌─────────────────────────────────────────────────────────────┐
│                    FRONTEND (React)                          │
│        (Web3.js, Redux, Tailwind CSS)                      │
└─────────────────────────────────────────────────────────────┘
                            ↕
┌─────────────────────────────────────────────────────────────┐
│              FINGERPRINTING SERVICE (Python)                 │
│        (Flask, NumPy, Model Analysis)                      │
└─────────────────────────────────────────────────────────────┘
```

##  Quick Start

### Prerequisites

- Node.js 18+
- Python 3.9+
- PostgreSQL
- Redis
- IPFS node (or use public gateway)
- MetaMask or compatible Web3 wallet

### 1. Clone and Setup

```bash
# Install contract dependencies
cd contracts
npm install

# Install backend dependencies
cd ../backend
npm install

# Install frontend dependencies
cd ../frontend
npm install

# Install Python dependencies
cd ../fingerprint-service
pip install -r requirements.txt
```

### 2. Configure Environment

#### Contracts
Create `contracts/.env`:
```env
PRIVATE_KEY=your_private_key_here
POLYGON_RPC_URL=https://rpc.ankr.com/polygon
MUMBAI_RPC_URL=https://rpc.ankr.com/polygon_mumbai
```

#### Backend
Create `backend/.env` from `backend/.env.example`:
```env
PORT=3000
DB_HOST=localhost
DB_PORT=5432
DB_NAME=ai_marketplace
DB_USER=postgres
DB_PASSWORD=postgres
REDIS_URL=redis://localhost:6379
RPC_URL=http://localhost:8545
IPFS_URL=http://localhost:5001
FINGERPRINT_SERVICE_URL=http://localhost:5000
```

#### Frontend
Create `frontend/.env`:
```env
VITE_API_URL=http://localhost:3000/api
```

### 3. Deploy Smart Contracts

```bash
cd contracts

# Deploy to local network
npx hardhat node  # In one terminal
npm run deploy:local  # In another terminal

# Or deploy to testnet
npm run deploy:mumbai
```

Update contract addresses in `backend/.env` after deployment.

### 4. Setup Database

```sql
-- Run the SQL schema from ai_marketplace_data_structures.md
-- Or use the provided schema in the documentation
```

### 5. Start Services

```bash
# Terminal 1: Start fingerprinting service
cd fingerprint-service
python src/app.py

# Terminal 2: Start backend
cd backend
npm run dev

# Terminal 3: Start frontend
cd frontend
npm run dev
```

### 6. Access Application

- Frontend: http://localhost:5173
- Backend API: http://localhost:3000
- Fingerprinting Service: http://localhost:5000

## Project Structure

```
.
├── contracts/              # Smart contracts (Solidity)
│   ├── contracts/         # Contract source files
│   ├── scripts/           # Deployment scripts
│   └── test/              # Contract tests
│
├── backend/               # Node.js backend API
│   ├── src/
│   │   ├── routes/       # API routes
│   │   ├── services/     # Business logic
│   │   ├── utils/        # Web3, IPFS, DB utilities
│   │   └── models/       # Data models
│   └── abis/             # Contract ABIs
│
├── frontend/              # React frontend
│   ├── src/
│   │   ├── components/   # React components
│   │   ├── pages/        # Page components
│   │   ├── store/        # Redux store
│   │   └── utils/        # Utilities
│
└── fingerprint-service/   # Python fingerprinting service
    └── src/
        └── app.py        # Flask API
```

##  Smart Contracts

### AIModelRegistry
- Model registration and ownership
- License management
- Dispute resolution
- Version control

### AIModelMarketplace
- Model listings (Fixed price, Auction, Subscription)
- Purchase transactions
- Royalty distribution
- Platform fees

### ModelVerification
- Model fingerprinting
- Plagiarism detection
- Verification records
- Similarity checking

## 📡 API Endpoints

### Models
- `GET /api/models` - List all models
- `GET /api/models/:modelId` - Get model details
- `POST /api/models/upload` - Upload new model
- `GET /api/models/search/:query` - Search models

### Users
- `GET /api/users/:address` - Get user profile
- `POST /api/users` - Create/update user

### Licenses
- `GET /api/licenses/user/:address` - Get user licenses
- `GET /api/licenses/:licenseId` - Get license details

### Marketplace
- `GET /api/marketplace/listings` - Get listings
- `POST /api/marketplace/listings` - Create listing
- `POST /api/marketplace/purchase` - Purchase model

### Verification
- `POST /api/verification/verify/:modelId` - Verify model
- `GET /api/verification/similar/:modelId` - Find similar models

##  Testing

```bash
# Test contracts
cd contracts
npm test

# Test backend (when tests are added)
cd backend
npm test

# Test fingerprinting service
cd fingerprint-service
pytest tests/
```

## Security Considerations

- Private keys should never be committed
- Use environment variables for sensitive data
- Validate all user inputs
- Implement rate limiting
- Use HTTPS in production
- Audit smart contracts before mainnet deployment

##  License

MIT License

##  Contributing

Contributions are welcome! Please open an issue or submit a pull request.

##  Documentation

See `ai_marketplace_data_structures.md` for detailed data structure documentation.

##  Support

For issues and questions, please open an issue on GitHub.

---

Built with for the decentralized AI economy


