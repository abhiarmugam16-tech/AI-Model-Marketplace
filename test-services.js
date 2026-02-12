// Quick test script to verify all services are running
const http = require('http');

const services = [
  { name: 'Fingerprinting Service', url: 'http://localhost:5000/health', port: 5000 },
  { name: 'Backend API', url: 'http://localhost:3000/health', port: 3000 },
  { name: 'Frontend', url: 'http://localhost:5173', port: 5173 }
];

console.log('🔍 Checking AI Model Marketplace Services...\n');

let checked = 0;
const total = services.length;

services.forEach((service) => {
  const req = http.get(service.url, (res) => {
    let data = '';
    res.on('data', (chunk) => { data += chunk; });
    res.on('end', () => {
      checked++;
      console.log(`✅ ${service.name} (Port ${service.port}) - RUNNING`);
      if (data) {
        try {
          const json = JSON.parse(data);
          console.log(`   Status: ${json.status || 'OK'}`);
        } catch (e) {
          // Not JSON, that's fine for frontend
        }
      }
      if (checked === total) {
        console.log('\n🎉 All services are running!');
        console.log('\n📱 Access your application:');
        console.log('   Frontend: http://localhost:5173');
        console.log('   Backend API: http://localhost:3000');
        console.log('   Fingerprinting: http://localhost:5000');
      }
    });
  });

  req.on('error', (err) => {
    checked++;
    console.log(`❌ ${service.name} (Port ${service.port}) - NOT RUNNING`);
    console.log(`   Error: ${err.message}`);
    if (checked === total) {
      console.log('\n⚠️  Some services are not running.');
      console.log('   Start them manually or use start-demo.bat');
    }
  });

  req.setTimeout(2000, () => {
    req.destroy();
    checked++;
    console.log(`⏱️  ${service.name} (Port ${service.port}) - TIMEOUT`);
    if (checked === total) {
      console.log('\n⚠️  Some services may not be running.');
    }
  });
});

