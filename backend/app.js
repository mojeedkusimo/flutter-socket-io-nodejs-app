const express = require('express');
const cors = require('cors');
const PORT = process.env.PORT || 3535

const app = express();
app.use(cors());

app.listen(PORT, () => {
    console.log('Server running on PORT: ', PORT)
});

app.use('/api', (req, res) => {
    res.json({
        status: 200,
        message: `You have successfully made a request to the server on port: ${PORT}`
    });
})
