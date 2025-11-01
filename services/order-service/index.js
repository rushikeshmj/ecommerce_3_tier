const express = require('express');
const app = express();
const port = process.env.PORT || 80;

app.get('/', (req, res) => {
  res.json({ service: 'order-service', status: 'ok' });
});

app.listen(port, () => {
  console.log('Service order-service listening on port', port);
});
