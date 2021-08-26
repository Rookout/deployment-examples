import rookout from 'rookout';
rookout.start();

import express from 'express';
const app = express();

app.get('/', (req, res) => res.send("Hello World"));
app.get("/hello/:name", (req, res) => {
    res.send("Hello, " + req.params.name);
});

app.listen(5000);