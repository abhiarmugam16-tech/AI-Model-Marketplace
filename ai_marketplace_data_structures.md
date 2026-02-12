# AI Model Marketplace - Data Structure Design

## 🏗️ Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                     BLOCKCHAIN LAYER                         │
│  (Immutable ownership, transactions, verification)          │
└─────────────────────────────────────────────────────────────┘
                            ↕
┌─────────────────────────────────────────────────────────────┐
│                   DECENTRALIZED STORAGE                      │
│              (IPFS - Model files & metadata)                 │
└─────────────────────────────────────────────────────────────┘
                            ↕
┌─────────────────────────────────────────────────────────────┐
│                    BACKEND DATABASE                          │
│        (PostgreSQL/MongoDB - Indexing & caching)            │
└─────────────────────────────────────────────────────────────┘
```

---

## 📦 1. SMART CONTRACT DATA STRUCTURES (Solidity)

### 1.1 Model Registry Contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AIModelRegistry {
    
    // Core model structure
    struct AIModel {
        uint256 modelId;              // Unique identifier
        address owner;                // Model creator/owner
        string modelHash;             // SHA-256 hash of model weights
        string ipfsHash;              // IPFS hash for model file
        string metadataIPFS;          // IPFS hash for metadata JSON
        uint256 timestamp;            // Upload timestamp
        ModelStatus status;           // Active, Deprecated, Disputed
        uint256 version;              // Model version number
        LicenseType licenseType;      // License category
    }
    
    // License types
    enum LicenseType {
        CommercialFull,    // Full commercial use
        CommercialLimited, // Limited commercial use
        Research,          // Research only
        OpenSource,        // Open source
        Custom            // Custom terms
    }
    
    // Model status
    enum ModelStatus {
        Pending,          // Awaiting verification
        Active,           // Available for sale
        Deprecated,       // Old version
        Disputed,         // Under dispute
        Banned           // Violated terms
    }
    
    // License purchase record
    struct License {
        uint256 licenseId;
        uint256 modelId;
        address buyer;
        address seller;
        uint256 price;              // In wei
        uint256 purchaseTime;
        LicenseType licenseType;
        uint256 expiryTime;         // 0 for perpetual
        bool isActive;
    }
    
    // Royalty structure for revenue sharing
    struct Royalty {
        address recipient;
        uint256 percentage;         // Basis points (100 = 1%)
    }
    
    // Version history
    struct ModelVersion {
        uint256 versionNumber;
        uint256 parentModelId;
        string ipfsHash;
        string modelHash;
        uint256 timestamp;
        string changeLog;
    }
    
    // Dispute resolution
    struct Dispute {
        uint256 disputeId;
        uint256 modelId;
        address claimant;
        address defendant;
        string evidence;            // IPFS hash of evidence
        DisputeStatus status;
        uint256 createdAt;
        uint256 resolvedAt;
    }
    
    enum DisputeStatus {
        Open,
        UnderReview,
        Resolved,
        Rejected
    }
    
    // Mappings
    mapping(uint256 => AIModel) public models;
    mapping(uint256 => License) public licenses;
    mapping(uint256 => ModelVersion[]) public versionHistory;
    mapping(uint256 => Royalty[]) public royalties;
    mapping(uint256 => Dispute[]) public disputes;
    mapping(address => uint256[]) public ownerModels;
    mapping(address => uint256[]) public buyerLicenses;
    mapping(string => uint256) public hashToModelId; // Prevent duplicates
    
    // Counters
    uint256 public modelCounter;
    uint256 public licenseCounter;
    uint256 public disputeCounter;
}
```

### 1.2 Marketplace Contract

```solidity
contract AIModelMarketplace {
    
    // Listing structure
    struct ModelListing {
        uint256 listingId;
        uint256 modelId;
        address seller;
        uint256 basePrice;          // Base price in wei
        bool isActive;
        ListingType listingType;
        uint256 listedAt;
        SaleTerms terms;
    }
    
    enum ListingType {
        FixedPrice,
        Auction,
        Subscription,
        PayPerUse
    }
    
    // Sale terms
    struct SaleTerms {
        uint256 minPrice;           // For auctions
        uint256 auctionEndTime;     // For auctions
        uint256 subscriptionDuration; // For subscriptions (in seconds)
        uint256 usageLimit;         // For pay-per-use
        bool allowResale;
        uint256 resaleRoyalty;      // Percentage to original creator
    }
    
    // Auction bid
    struct Bid {
        uint256 bidId;
        uint256 listingId;
        address bidder;
        uint256 amount;
        uint256 timestamp;
        bool isActive;
    }
    
    // Transaction record
    struct Transaction {
        uint256 txId;
        uint256 modelId;
        address from;
        address to;
        uint256 amount;
        uint256 timestamp;
        TransactionType txType;
    }
    
    enum TransactionType {
        DirectSale,
        AuctionSale,
        SubscriptionPayment,
        RoyaltyPayment,
        Refund
    }
    
    mapping(uint256 => ModelListing) public listings;
    mapping(uint256 => Bid[]) public auctionBids;
    mapping(uint256 => Transaction) public transactions;
}
```

### 1.3 Verification Contract

```solidity
contract ModelVerification {
    
    // Verification record
    struct VerificationRecord {
        uint256 modelId;
        address verifier;           // Can be oracle or trusted entity
        VerificationStatus status;
        uint256 timestamp;
        string reportIPFS;          // Detailed verification report
        VerificationMethod method;
    }
    
    enum VerificationStatus {
        Unverified,
        Verified,
        Failed,
        Suspicious
    }
    
    enum VerificationMethod {
        HashVerification,       // Basic hash matching
        BehaviorTest,          // Model behavior testing
        CodeAudit,            // Smart contract audit style
        CommunityVote,        // DAO-style verification
        OracleVerified        // Third-party oracle
    }
    
    // Model fingerprint for anti-plagiarism
    struct ModelFingerprint {
        uint256 modelId;
        bytes32 weightHash;         // Hash of model weights
        bytes32 architectureHash;   // Hash of model architecture
        uint256[] layerSignature;   // Signature of layer dimensions
        string fingerprintIPFS;     // Detailed fingerprint data
    }
    
    mapping(uint256 => VerificationRecord[]) public verifications;
    mapping(uint256 => ModelFingerprint) public fingerprints;
    mapping(bytes32 => uint256) public fingerprintToModel; // Detect copies
}
```

---

## 🗄️ 2. OFF-CHAIN DATABASE STRUCTURES (PostgreSQL)

### 2.1 Users Table
```sql
CREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    wallet_address VARCHAR(42) UNIQUE NOT NULL,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(255),
    profile_ipfs_hash VARCHAR(100),
    reputation_score DECIMAL(5,2) DEFAULT 0,
    total_models_uploaded INTEGER DEFAULT 0,
    total_licenses_sold INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_verified BOOLEAN DEFAULT FALSE,
    kyc_status VARCHAR(20) DEFAULT 'pending'
);

CREATE INDEX idx_wallet ON users(wallet_address);
CREATE INDEX idx_username ON users(username);
```

### 2.2 Models Cache Table (for faster querying)
```sql
CREATE TABLE models_cache (
    model_id BIGINT PRIMARY KEY,
    blockchain_model_id BIGINT NOT NULL,
    owner_address VARCHAR(42) NOT NULL,
    model_name VARCHAR(255) NOT NULL,
    description TEXT,
    category VARCHAR(50),
    framework VARCHAR(50),  -- tensorflow, pytorch, etc.
    model_size_mb DECIMAL(10,2),
    ipfs_hash VARCHAR(100) NOT NULL,
    metadata_ipfs VARCHAR(100),
    model_hash VARCHAR(64) NOT NULL,
    status VARCHAR(20),
    version VARCHAR(20),
    download_count INTEGER DEFAULT 0,
    view_count INTEGER DEFAULT 0,
    rating_avg DECIMAL(3,2) DEFAULT 0,
    rating_count INTEGER DEFAULT 0,
    price_wei NUMERIC(78,0),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    
    FOREIGN KEY (owner_address) REFERENCES users(wallet_address)
);

CREATE INDEX idx_category ON models_cache(category);
CREATE INDEX idx_owner ON models_cache(owner_address);
CREATE INDEX idx_created ON models_cache(created_at DESC);
```

### 2.3 Model Metadata (Extended Info)
```sql
CREATE TABLE model_metadata (
    metadata_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    model_id BIGINT NOT NULL,
    
    -- Technical details
    framework VARCHAR(50),
    framework_version VARCHAR(20),
    architecture_type VARCHAR(100),  -- CNN, Transformer, LSTM, etc.
    input_shape JSONB,
    output_shape JSONB,
    parameter_count BIGINT,
    
    -- Performance metrics
    accuracy DECIMAL(5,4),
    precision_score DECIMAL(5,4),
    recall DECIMAL(5,4),
    f1_score DECIMAL(5,4),
    inference_time_ms DECIMAL(10,2),
    
    -- Training details
    training_dataset VARCHAR(255),
    training_epochs INTEGER,
    training_duration_hours DECIMAL(10,2),
    
    -- Use case
    use_case TEXT[],
    tags TEXT[],
    compatible_hardware TEXT[],
    min_requirements JSONB,
    
    -- Documentation
    readme_ipfs VARCHAR(100),
    demo_ipfs VARCHAR(100),
    api_doc_ipfs VARCHAR(100),
    
    FOREIGN KEY (model_id) REFERENCES models_cache(model_id)
);
```

### 2.4 Licenses Cache
```sql
CREATE TABLE licenses_cache (
    license_id BIGINT PRIMARY KEY,
    blockchain_license_id BIGINT NOT NULL,
    model_id BIGINT NOT NULL,
    buyer_address VARCHAR(42) NOT NULL,
    seller_address VARCHAR(42) NOT NULL,
    price_wei NUMERIC(78,0),
    license_type VARCHAR(50),
    purchase_date TIMESTAMP,
    expiry_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    download_limit INTEGER,
    downloads_used INTEGER DEFAULT 0,
    
    FOREIGN KEY (model_id) REFERENCES models_cache(model_id),
    FOREIGN KEY (buyer_address) REFERENCES users(wallet_address),
    FOREIGN KEY (seller_address) REFERENCES users(wallet_address)
);

CREATE INDEX idx_buyer_licenses ON licenses_cache(buyer_address);
CREATE INDEX idx_model_licenses ON licenses_cache(model_id);
```

### 2.5 Reviews & Ratings
```sql
CREATE TABLE reviews (
    review_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    model_id BIGINT NOT NULL,
    reviewer_address VARCHAR(42) NOT NULL,
    license_id BIGINT,  -- Must own license to review
    rating INTEGER CHECK (rating >= 1 AND rating <= 5),
    review_text TEXT,
    review_ipfs VARCHAR(100),  -- For detailed reviews
    helpful_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (model_id) REFERENCES models_cache(model_id),
    FOREIGN KEY (reviewer_address) REFERENCES users(wallet_address),
    FOREIGN KEY (license_id) REFERENCES licenses_cache(license_id),
    UNIQUE(model_id, reviewer_address)  -- One review per user per model
);
```

### 2.6 Download Activity
```sql
CREATE TABLE download_logs (
    log_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    model_id BIGINT NOT NULL,
    license_id BIGINT NOT NULL,
    user_address VARCHAR(42) NOT NULL,
    download_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ipfs_gateway VARCHAR(255),
    file_size_bytes BIGINT,
    download_duration_seconds INTEGER,
    ip_hash VARCHAR(64),  -- Hashed for privacy
    
    FOREIGN KEY (model_id) REFERENCES models_cache(model_id),
    FOREIGN KEY (license_id) REFERENCES licenses_cache(license_id)
);

CREATE INDEX idx_download_user ON download_logs(user_address);
CREATE INDEX idx_download_model ON download_logs(model_id);
```

---

## 📁 3. IPFS DATA STRUCTURES (JSON)

### 3.1 Model Metadata JSON
```json
{
  "modelId": "12345",
  "name": "ImageClassifier-ResNet50",
  "version": "1.2.0",
  "description": "Pre-trained ResNet50 for image classification",
  
  "technical": {
    "framework": "PyTorch",
    "frameworkVersion": "2.0.1",
    "architecture": "ResNet50",
    "inputShape": [3, 224, 224],
    "outputShape": [1000],
    "parameters": 25557032,
    "modelSize": "97.8 MB",
    "quantization": "fp32"
  },
  
  "performance": {
    "accuracy": 0.945,
    "topK": {
      "top1": 0.945,
      "top5": 0.987
    },
    "inferenceTime": {
      "cpu": "45ms",
      "gpu": "3ms"
    },
    "benchmark": "ImageNet-1K"
  },
  
  "training": {
    "dataset": "ImageNet-1K",
    "epochs": 90,
    "batchSize": 256,
    "optimizer": "SGD",
    "learningRate": 0.1,
    "hardware": "8x NVIDIA V100"
  },
  
  "usage": {
    "categories": ["computer-vision", "classification"],
    "useCases": ["product recognition", "medical imaging", "autonomous vehicles"],
    "tags": ["resnet", "imagenet", "pretrained"],
    "license": "MIT",
    "commercial": true
  },
  
  "files": {
    "weights": "QmX1...",  // IPFS hash
    "config": "QmX2...",
    "readme": "QmX3...",
    "demo": "QmX4...",
    "examples": "QmX5..."
  },
  
  "fingerprint": {
    "weightsHash": "0x1234...",
    "architectureHash": "0x5678...",
    "layerSignature": [64, 256, 512, 1024, 2048]
  },
  
  "creator": {
    "address": "0xABC...",
    "name": "AI Research Lab",
    "website": "https://example.com",
    "contact": "contact@example.com"
  }
}
```

### 3.2 Verification Report JSON
```json
{
  "verificationId": "ver_67890",
  "modelId": "12345",
  "timestamp": "2024-02-06T10:30:00Z",
  "verifier": "0xDEF...",
  
  "checks": {
    "hashVerification": {
      "passed": true,
      "expectedHash": "0x1234...",
      "actualHash": "0x1234...",
      "method": "SHA-256"
    },
    
    "plagiarismCheck": {
      "passed": true,
      "similarModels": [],
      "confidence": 0.99
    },
    
    "behaviorTest": {
      "passed": true,
      "testCases": 100,
      "passed": 98,
      "failed": 2,
      "accuracy": 0.943
    },
    
    "securityScan": {
      "passed": true,
      "malwareDetected": false,
      "suspiciousCode": false,
      "backdoorDetected": false
    },
    
    "licenseCheck": {
      "passed": true,
      "licenseType": "MIT",
      "commercialUse": true,
      "attribution": true
    }
  },
  
  "overallStatus": "VERIFIED",
  "confidence": 0.97,
  "notes": "All checks passed successfully",
  "signature": "0x789..."
}
```

---

## 🔧 4. BACKEND API DATA STRUCTURES (Node.js/Express)

### 4.1 Request/Response DTOs (Data Transfer Objects)

```javascript
// Model Upload Request
class ModelUploadRequest {
  constructor() {
    this.name = '';              // string
    this.description = '';       // string
    this.category = '';          // string
    this.framework = '';         // string
    this.version = '';           // string
    this.file = null;            // File object
    this.metadata = {};          // ModelMetadata object
    this.licenseType = '';       // LicenseType enum
    this.price = 0;              // number (in ETH)
    this.ownerAddress = '';      // string (0x...)
    this.signature = '';         // string (signed message)
  }
}

// Model Response
class ModelResponse {
  constructor() {
    this.modelId = 0;
    this.name = '';
    this.description = '';
    this.owner = {};             // UserProfile object
    this.ipfsHash = '';
    this.modelHash = '';
    this.price = 0;
    this.licenseType = '';
    this.status = '';
    this.version = '';
    this.downloads = 0;
    this.rating = 0;
    this.verified = false;
    this.createdAt = '';
    this.updatedAt = '';
    this.metadata = {};
  }
}

// Search/Filter Parameters
class ModelSearchParams {
  constructor() {
    this.query = '';             // Search text
    this.category = [];          // Array of categories
    this.framework = [];         // Array of frameworks
    this.minPrice = 0;
    this.maxPrice = 0;
    this.verified = null;        // boolean or null
    this.sortBy = 'createdAt';   // createdAt, price, rating, downloads
    this.sortOrder = 'desc';     // asc, desc
    this.page = 1;
    this.limit = 20;
  }
}
```

### 4.2 Cache Structure (Redis)

```javascript
// Redis key patterns
const REDIS_KEYS = {
  // Model cache: 'model:{modelId}'
  MODEL: (id) => `model:${id}`,
  
  // User cache: 'user:{address}'
  USER: (address) => `user:${address}`,
  
  // Trending models: 'trending:models' (sorted set by score)
  TRENDING: 'trending:models',
  
  // Recently uploaded: 'recent:models' (list)
  RECENT: 'recent:models',
  
  // Model views counter: 'views:{modelId}'
  VIEWS: (id) => `views:${id}`,
  
  // Search results cache: 'search:{hash}'
  SEARCH: (hash) => `search:${hash}`,
  
  // Active sessions: 'session:{sessionId}'
  SESSION: (id) => `session:${id}`
};

// Example cached model object
const cachedModel = {
  modelId: 12345,
  name: 'ImageClassifier',
  price: '1000000000000000000', // 1 ETH in wei
  rating: 4.7,
  downloads: 1523,
  verified: true,
  ipfsHash: 'QmX...',
  ttl: 3600  // Cache for 1 hour
};
```

---

## 🎨 5. FRONTEND STATE MANAGEMENT (React/Redux)

### 5.1 Redux Store Structure

```javascript
const initialState = {
  // User state
  user: {
    address: null,
    profile: null,
    isConnected: false,
    balance: 0,
    ownedModels: [],
    purchasedLicenses: [],
    loading: false,
    error: null
  },
  
  // Models state
  models: {
    items: {},              // { [modelId]: ModelObject }
    list: [],               // Array of model IDs
    featured: [],
    trending: [],
    recent: [],
    totalCount: 0,
    loading: false,
    error: null
  },
  
  // Search/Filter state
  search: {
    query: '',
    filters: {
      category: [],
      framework: [],
      priceRange: [0, 1000],
      verified: null
    },
    results: [],
    loading: false
  },
  
  // Cart/Purchase state
  cart: {
    items: [],              // Array of { modelId, licenseType }
    total: 0
  },
  
  // Blockchain state
  blockchain: {
    network: 'polygon',
    blockNumber: 0,
    gasPrice: 0,
    transactions: [],       // Pending transactions
    confirmations: {}       // { [txHash]: confirmationCount }
  },
  
  // UI state
  ui: {
    sidebarOpen: true,
    theme: 'dark',
    notifications: []
  }
};
```

---

## 🔐 6. MODEL FINGERPRINTING DATA STRUCTURE (Python)

```python
from dataclasses import dataclass
from typing import List, Dict, Any
import hashlib
import numpy as np

@dataclass
class ModelFingerprint:
    """
    Comprehensive fingerprint for AI model identification
    """
    model_id: int
    
    # Hash-based identifiers
    weights_hash: str          # SHA-256 of all weights
    architecture_hash: str     # Hash of model structure
    
    # Layer signatures
    layer_dimensions: List[tuple]  # Shape of each layer
    layer_types: List[str]         # Type of each layer
    total_parameters: int
    
    # Weight statistics (for similarity detection)
    weight_distribution: Dict[str, float]  # mean, std, min, max
    activation_patterns: List[np.ndarray]  # Sample activation outputs
    
    # Metadata
    framework: str
    framework_version: str
    creation_timestamp: int
    
    # Advanced fingerprinting
    gradient_signature: str    # Hash of gradient behavior
    embedding_sample: np.ndarray  # Sample embeddings for comparison
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            'model_id': self.model_id,
            'weights_hash': self.weights_hash,
            'architecture_hash': self.architecture_hash,
            'layer_dimensions': self.layer_dimensions,
            'layer_types': self.layer_types,
            'total_parameters': self.total_parameters,
            'weight_distribution': self.weight_distribution,
            'framework': self.framework,
            'framework_version': self.framework_version,
            'creation_timestamp': self.creation_timestamp
        }
    
    @staticmethod
    def generate(model: Any) -> 'ModelFingerprint':
        """Generate fingerprint from a model"""
        # Implementation would extract actual model properties
        pass
```

---

## 📊 7. ANALYTICS DATA STRUCTURES

### 7.1 Analytics Events (MongoDB/Time-series DB)

```javascript
// Event schema for analytics
const analyticsEventSchema = {
  eventId: String,
  eventType: String,  // 'model_view', 'model_download', 'purchase', etc.
  timestamp: Date,
  userId: String,
  modelId: Number,
  
  // Event-specific data
  data: {
    priceETH: Number,
    licenseType: String,
    referrer: String,
    device: String,
    location: String,
    // ... other contextual data
  },
  
  // Session tracking
  sessionId: String,
  
  // Attribution
  source: String,
  medium: String,
  campaign: String
};

// Aggregated statistics
const modelStatsSchema = {
  modelId: Number,
  date: Date,  // Daily aggregation
  
  views: Number,
  uniqueViewers: Number,
  downloads: Number,
  purchases: Number,
  revenue: Number,  // In wei
  
  // User engagement
  avgViewDuration: Number,
  bounceRate: Number,
  conversionRate: Number,
  
  // Geographic distribution
  topCountries: Array,
  
  // Updated timestamp
  updatedAt: Date
};
```

---

## 🔄 8. EVENT SYSTEM (Blockchain Events → Backend Sync)

```javascript
// Event listener structure for blockchain synchronization
const blockchainEvents = {
  
  ModelRegistered: {
    eventSignature: 'ModelRegistered(uint256,address,string,string,uint256)',
    handler: async (event) => {
      const { modelId, owner, modelHash, ipfsHash, timestamp } = event.returnValues;
      // Sync to database
      await syncModelToDatabase(modelId, owner, modelHash, ipfsHash, timestamp);
    }
  },
  
  LicensePurchased: {
    eventSignature: 'LicensePurchased(uint256,uint256,address,address,uint256)',
    handler: async (event) => {
      const { licenseId, modelId, buyer, seller, price } = event.returnValues;
      await syncLicenseToDatabase(licenseId, modelId, buyer, seller, price);
      await updateModelStats(modelId);
    }
  },
  
  DisputeRaised: {
    eventSignature: 'DisputeRaised(uint256,uint256,address,address)',
    handler: async (event) => {
      // Handle dispute notification
      await notifyDisputeParties(event.returnValues);
    }
  }
};
```

---

## 🎯 Summary

This design provides:

✅ **On-chain structures** for trustless ownership & transactions  
✅ **Off-chain database** for performance & rich querying  
✅ **IPFS metadata** for decentralized storage  
✅ **Frontend state** for smooth UX  
✅ **Fingerprinting** for anti-plagiarism  
✅ **Analytics** for marketplace insights  
✅ **Event sync** for blockchain ↔ database consistency

**Key Design Decisions:**
- Hybrid architecture (blockchain + traditional DB) for best of both worlds
- IPFS for large file storage to keep blockchain lean
- Comprehensive fingerprinting to prevent model theft
- Rich metadata for discoverability
- Multi-tier caching (Redis) for performance
- Event-driven sync for data consistency

This creates a robust, scalable foundation for your AI Model Marketplace! 🚀
