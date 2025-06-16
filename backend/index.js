const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

const app = require('./app');
//const app = express();

const uri = "mongodb+srv://gopick2004:GopiGopika2022@clusterclassconnect.fv2qvdh.mongodb.net/?retryWrites=true&w=majority&appName=ClusterClassConnect";

mongoose.connect(uri)
.then(() => {
  console.log('Connected to MongoDB');
})
.catch((error) => {
  console.error('Error connecting to MongoDB:', error.message);
});

app.use(bodyParser.json());
app.use(express.json());
const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`Server listening on port ${port}`);
});
