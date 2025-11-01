const express = require('express');
const app = express();
const port = process.env.PORT || 80;

app.get('/', (req, res) => {
  res.json({ service: 'shipping-service', status: 'ok' });
});

app.listen(port, () => {
  console.log('Service shipping-service listening on port', port);
});
