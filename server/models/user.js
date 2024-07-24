const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true, 
  },
  email: {
    type: String,
    required: true,
    trim: true,
    validate: {
      validator: (value) => {
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(re);
      },
      message: "Please enter a valid email address",
    },
  },
  phoneNumber: {
    type: String,
    required: true,
    validate: {
      validator: (value) => {
        return /^\d{10}$/.test(value); 
      },
      message: "Please enter a valid phone number",
    },
  },
  password: {
    type: String,
    required: true,
  },
  position:{
    type: String,
    required: true,
  }
});

const User = mongoose.model("User", userSchema);
module.exports = User;
