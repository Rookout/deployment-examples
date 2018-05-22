const rook = require('rookout/auto_start');

const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => res.send('Hello World!' + '<br/>' + new Date().toLocaleString()));

app.listen(PORT, () => console.log(`Example app listening on port ${PORT}`));