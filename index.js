const http = require('http');
const server = http.createServer((req, res) => {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('DevOps Automation Successful! Verified on June 8, 2026\n');
});
server.listen(process.env.PORT || 3000);
