const express = require('express');
const bodyParser = require('body-parser'); // Corrected import name
const SloginRouter = require('./routers/SloginRouter'); // Corrected import name

const app = express();
//app.use(bodyParser.json());
// Middleware to parse JSON and URL-encoded bodies
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: false }));

// Mounting the SloginRouter to handle routes starting from the root URL
app.use('/', SloginRouter);

// Error handling middleware
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something broke!');
});

module.exports = app;
