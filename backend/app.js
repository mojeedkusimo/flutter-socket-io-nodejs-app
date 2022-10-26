const express = require('express');
const cors = require('cors');
const http = require('http');
const app = express();
const server = http.createServer(app);
const io = require('socket.io')(server, {
    cors: {
        origin: '*'
    }
});

const PORT = process.env.PORT || 3535

app.use(cors());

io.on('connection', (socket) => {
    console.log('connected to socket...')
})
app.listen(PORT, () => {
    console.log('Server running on PORT:', PORT)
});

app.use('/api', (req, res) => {
    res.json({
        status: 200,
        message: `You have successfully made a request to the server on port: ${PORT}`
    });
});
