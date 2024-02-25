const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
    lowercase: true,
    index: true,
  },
  phone: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
  img_url:{
    type : String
  }
});

userSchema.methods.checkPassword = function(candidatePassword) {
  return this.password === candidatePassword;
};

const User = mongoose.model('User', userSchema);

module.exports = User;
