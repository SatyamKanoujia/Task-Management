const mongoose = require("mongoose");

const taskSchema = mongoose.Schema({
  uid:{
    required: true,
    type: String,
  },
  title: {
    type: String,
    required: true,
    trim: true,
  },
  description: {
    type: String,
    required: true,
    trim: true,
  },
  date: {
    type: String,
    required: true,
  },
  time: {
    type: String,
    required: true,
  },
  isCompleted:{
    type: Boolean,
    required: true,
  }

});
const Task = mongoose.model("Task", taskSchema);
module.exports = { Task, taskSchema };

 