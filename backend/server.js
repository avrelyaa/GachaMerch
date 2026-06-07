const express = require('express');
const cors = require('cors');
require('dotenv').config();

const authRoutes = require('./routes/auth');
const resourceRoutes = require('./routes/resources');

const app = express();

app.use(cors());
app.use(express.json());

app.use('/auth', authRoutes);
app.use('/resources', resourceRoutes);

app.get('/', (req, res) => {
  res.json({ message: 'GachaMerch API is running.' });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`GachaMerch backend running on http://localhost:${PORT}`);
});