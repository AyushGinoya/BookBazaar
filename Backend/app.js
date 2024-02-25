const express = require('express');
const session = require('express-session');
const { MongoClient } = require('mongodb');
const app = express();
const User = require('./models/user');
const Book = require('./models/book');

const bodyParser = require('body-parser');
const port = 3000;
const env = require('dotenv');
const mongoose = require('mongoose');
const multer = require('multer');
const cloudinary = require('cloudinary').v2;
cloudinary.config({ 
  cloud_name: 'dspsdpx5c', 
  api_key: '637215419864166', 
  api_secret: 'sVB4INWe3v5JHUVzEsLWMbao37s'
});


const upload = multer({ dest: 'uploads/' });
env.config({
    path: "./config.env"
})
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(session({
  secret: 'RajPansara', // replace with a secret key
  resave: false,
  saveUninitialized: true
}));
const { Mongouri } = process.env;

const connectDB = async () => {
  try {
      mongoose.set('strictQuery', true);
      await mongoose.connect(Mongouri);

      console.log('MongoDB is Connected...');
  } catch (err) {
      console.error(err.message);
      process.exit(1);
  }
};

connectDB();
app.get('/', (req, res) => {
  res.send('Welcome to my server!');
});

app.post('/signup', async (req, res) => {
    const { name, email, phone, password} = req.body;
  
    if (!name || !email || !phone || !password) {
      return res.status(400).json({ message: 'Please provide all required fields.' });
    }
    try {
      const existingUser = await User.findOne({ email });
  
      if (existingUser) {
        return res.status(409).json({ message: 'User with this email already exists.' });
      }
      

      const newUser = new User({
        name,
        email,
        phone,
        password,
      });
      await newUser.save();
  
      res.status(201).json({ message: 'User registered successfully.', userId: newUser._id });
    } catch (error) {
      console.error('Error during signup:', error);
      res.status(500).json({ message: 'Internal server error.' });
    }
  });


  app.post('/login', async (req, res) => {
    const { email, password } = req.body;
  
    if (!email || !password) {
      return res.status(400).json({ message: 'Please provide both email and password.' });
    }
  
    try {
      // Check if the user exists
      const user = await User.findOne({ email });
  
      if (!user) {
        return res.status(401).json({ message: 'Invalid credentials.' });
      }
  
      // Validate the password using the checkPassword method
      const isPasswordValid = user.checkPassword(password);
  
      if (!isPasswordValid) {
        return res.status(401).json({ message: 'Invalid credentials.' });
      }
  
      // Store user information in the session
      req.session.user = {
        _id: user._id,
        email: user.email,
        // Add any additional user information needed in the session
      };
  
      res.status(200).json({ message: 'Login successful.' });
    } catch (error) {
      console.error('Error during login:', error);
      res.status(500).json({ message: 'Internal server error.' });
    }
  });
  
  app.post('/img_url', async (req, res) => {
    // Check if user is authenticated (assumes you have middleware for authentication)
    if (!req.session.user) {
      return res.status(401).json({ error: 'Unauthorized' });
    }
  
    // Assuming img_url is passed in the request body or query parameters
    const { img_url } = req.body;
  
    if (!img_url) {
      return res.status(400).json({ error: 'Missing img_url in the request.' });
    }
  
    try {
      const cloudinaryResponse = await cloudinary.uploader.upload(img_url, {
        resource_type: 'image',
      });
  
      const imageUrl = cloudinaryResponse.secure_url;
      await User.findByIdAndUpdate(req.session.user._id, { img_url: imageUrl });
  
      res.status(200).json({ message: 'Image uploaded successfully.' });
    } catch (error) {
      console.error('Error during image upload:', error);
      res.status(500).json({ error: 'Internal server error.' });
    }
  });

  app.post('/add-book', async (req, res) => {
    const { name, author, price } = req.body;
  
    // Validate that all required fields are provided
    if (!name || !author || !price) {
      return res.status(400).json({ error: 'Please provide all required fields.' });
    }
  
    try {
      // Create a new book instance using the Book model
      const newBook = new Book({
        name,
        author,
        price,
      });
  
      // Save the new book to the database
      await newBook.save();
  
      res.status(201).json({ message: 'Book added successfully.', book: newBook });
    } catch (error) {
      console.error('Error adding book:', error);
      res.status(500).json({ error: 'Internal server error.' });
    }
  });

  // Route to get all books
app.get('/get-all-books', async (req, res) => {
  try {
    // Retrieve all books from the database
    const allBooks = await Book.find();

    res.status(200).json({ books: allBooks });
  } catch (error) {
    console.error('Error retrieving books:', error);
    res.status(500).json({ error: 'Internal server error.' });
  }
});
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});