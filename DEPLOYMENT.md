# Deployment Guide

## Prerequisites

1. **Blockchain Network**: Choose your network (Polygon, Mumbai testnet, or local)
2. **IPFS Node**: Set up IPFS node or use public gateway
3. **Database**: PostgreSQL instance
4. **Redis**: Redis instance for caching
5. **Domain**: (Optional) For production deployment

## Step-by-Step Deployment

### 1. Deploy Smart Contracts

```bash
cd contracts

# Install dependencies
npm install

# Configure .env with your private key and RPC URL
cp .env.example .env
# Edit .env with your values

# Compile contracts
npm run compile

# Deploy to testnet
npm run deploy:mumbai

# Or deploy to mainnet (Polygon)
npm run deploy:polygon
```

After deployment, note the contract addresses and update `backend/.env`.

### 2. Setup Database

```bash
# Create database
createdb ai_marketplace

# Run schema
psql -d ai_marketplace -f backend/database/schema.sql
```

### 3. Configure Backend

```bash
cd backend

# Install dependencies
npm install

# Configure environment
cp .env.example .env
# Edit .env with:
# - Database credentials
# - Redis URL
# - Contract addresses from step 1
# - IPFS URL
# - Fingerprinting service URL
```

### 4. Setup Fingerprinting Service

```bash
cd fingerprint-service

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Run service
python src/app.py
```

### 5. Build and Deploy Frontend

```bash
cd frontend

# Install dependencies
npm install

# Configure environment
cp .env.example .env
# Edit .env with backend API URL

# Build for production
npm run build

# Deploy dist/ folder to your hosting service
# (Vercel, Netlify, AWS S3, etc.)
```

### 6. Start Backend (Production)

```bash
cd backend

# Using PM2
npm install -g pm2
pm2 start src/server.js --name ai-marketplace-api

# Or using Docker
docker build -t ai-marketplace-backend .
docker run -p 3000:3000 ai-marketplace-backend
```

## Docker Deployment

### Backend Dockerfile

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 3000
CMD ["node", "src/server.js"]
```

### Fingerprinting Service Dockerfile

```dockerfile
FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python", "src/app.py"]
```

## Environment Variables Checklist

### Contracts
- [ ] PRIVATE_KEY
- [ ] POLYGON_RPC_URL or MUMBAI_RPC_URL

### Backend
- [ ] DB_HOST, DB_PORT, DB_NAME, DB_USER, DB_PASSWORD
- [ ] REDIS_URL
- [ ] RPC_URL
- [ ] REGISTRY_CONTRACT_ADDRESS
- [ ] MARKETPLACE_CONTRACT_ADDRESS
- [ ] VERIFICATION_CONTRACT_ADDRESS
- [ ] IPFS_URL
- [ ] FINGERPRINT_SERVICE_URL

### Frontend
- [ ] VITE_API_URL

## Production Checklist

- [ ] Smart contracts deployed and verified
- [ ] Contract addresses configured in backend
- [ ] Database schema created
- [ ] Redis instance running
- [ ] IPFS node accessible
- [ ] Environment variables set
- [ ] HTTPS enabled
- [ ] CORS configured correctly
- [ ] Rate limiting enabled
- [ ] Error logging configured
- [ ] Monitoring set up
- [ ] Backup strategy in place

## Monitoring

Consider setting up:
- Application monitoring (Sentry, LogRocket)
- Blockchain monitoring (The Graph, Alchemy)
- Database monitoring
- Server monitoring (New Relic, Datadog)

## Security

- Use environment variables for all secrets
- Enable HTTPS
- Implement rate limiting
- Use secure database connections
- Regular security audits
- Keep dependencies updated

