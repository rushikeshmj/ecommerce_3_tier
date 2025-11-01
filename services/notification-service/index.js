const express = require('express');
const app = express();
const port = process.env.PORT || 80;

app.get('/', (req, res) => {
  res.json({ service: 'notification-service', status: 'ok' });
});

app.listen(port, () => {
  console.log('Service notification-service listening on port', port);
});
