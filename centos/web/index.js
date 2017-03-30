"use strict";

const express = require('express');  
const app = express();

app.get('/', (req, res) => {  
    res.type('image/svg+xml');
    res.send(getsvg(req.query.title || 'hello', req.query.color, req.query.label, req.query.flat));
    res.end();
});

function getsvg(title, color, label, flat) {  
    // 此处省略 ...
}

// note：这里用到一个环境变量
let port = process.env.HTTP_PORT || 8000;

app.listen(port, () => {  
    console.log('Listening on port %s', port);
});