const express = require('express');
const app = express();
const port = process.env.PORT || 80;

app.get('/', (req, res) => {
  res.json({ service: 'api-gateway', status: 'ok' });
});

app.listen(port, () => {
  console.log('Service api-gateway listening on port', port);
});
