const express = require("express");
const taskRouter = express.Router();
const { Task } = require("../models/task");
const auth = require("../middlewares/auth");
const mongoose = require('mongoose');

// Add task
taskRouter.post("/task/add-task", auth,async (req, res) => {
  try {
    const { uid,title, description, date, time ,isCompleted} = req.body;
    let task = new Task({
      uid,
      title,
      description,
      date,
      time,
      isCompleted,
    });
    task = await task.save();
    return res.json(task);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

//Get all your task
taskRouter.get("/task/get-tasks",auth, async (req, res) => {
  try {
    let tasks = await Task.find({uid: req.user});
    return res.json(tasks);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

// Delete the task
taskRouter.post("/task/delete-task", auth, async (req, res) => {
  try {
    const { id } = req.body;

    if (!mongoose.Types.ObjectId.isValid(id)) {
      return res.status(400).json({ error: "Invalid task ID" });
    }

    let task = await Task.findByIdAndDelete(id);

    if (!task) {
      return res.status(404).json({ error: "Task not found" });
    }

    return res.json(task);
  } catch (e) {
    console.error("Error deleting task:", e);
    return res.status(500).json({ error: e.message });
  }
});

taskRouter.post("/task/update-status", auth, async (req, res) => {
  try {
    const { _id, isCompleted } = req.body;

    if (!mongoose.Types.ObjectId.isValid(_id)) {
      return res.status(400).json({ error: "Invalid task ID" });
    }

    let task = await Task.findByIdAndUpdate(_id, { isCompleted: isCompleted }, { new: true });

    if (!task) {
      return res.status(404).json({ error: "Task not found" });
    }

    return res.json(task);
  } catch (e) {
    console.error("Error updating task status:", e);
    return res.status(500).json({ error: e.message });
  }
});

// Update task
taskRouter.put("/task/update-task/:id", auth, async (req, res) => {
  try {
    const { id } = req.params;
    const { title, description, date, time, isCompleted } = req.body;

    if (!mongoose.Types.ObjectId.isValid(id)) {
      return res.status(400).json({ error: "Invalid task ID" });
    }

    let task = await Task.findByIdAndUpdate(
      id,
      { title, description, date, time, isCompleted },
      { new: true }
    );

    if (!task) {
      return res.status(404).json({ error: "Task not found" });
    }

    return res.json(task);
  } catch (e) {
    console.error("Error updating task:", e);
    return res.status(500).json({ error: e.message });
  }
});

// Get tasks for a specific user
taskRouter.get("/task/get-task", auth, async (req, res) => {
  try {
    const { uid } = req.query;

    if (!uid) {
      return res.status(400).json({ error: "Missing uid parameter" });
    }

    let tasks = await Task.find({ uid });
    return res.json(tasks);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

// Assign task
taskRouter.post("/task/assign-task", auth, async (req, res) => {
  try {
    const { uid, title, description, date, time, isCompleted } = req.body;
    let task = new Task({
      uid,
      title,
      description,
      date,
      time,
      isCompleted,
    });
    task = await task.save();
    return res.json(task);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

module.exports = taskRouter;