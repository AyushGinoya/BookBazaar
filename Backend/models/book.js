const mongoose = require('mongoose');

const bookSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  author: {
    type: String,
    required: true,
  },
  price: {
    type: Number,
    required: true,
  },
  img_url_book : {
    type:String,
    required: true,
  }
});

const Book = mongoose.model('Book', bookSchema);

module.exports = Book;
