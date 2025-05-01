import express from 'express';
import mongoose from 'mongoose';
import dotenv from 'dotenv';
import cors from 'cors';
import authRoutes from './routes/authRoutes.js';
import deviceRoutes from './routes/deviceRoutes.js'
import billRoutes from './routes/billRoutes.js';


const app = express();
const port = 3000;

app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: true }));

//Routes
app.use('/auth',authRoutes);
app.use('/device',deviceRoutes);
app.use("/bill", billRoutes);

dotenv.config();

mongoose.connect(process.env.MONGODB_URI)
  .then(() => console.log('Connected to MongoDB'))
  .catch((err) => console.error('MongoDB connection error:', err));



app.get('/', (req, res) => {
    res.send('Welcome to ElectroBill!');
});

app.listen(port, () => {
    console.log(`ElectroBill server is running on http://localhost:${port}`);
});
