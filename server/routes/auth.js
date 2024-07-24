const express = require("express");
const User = require("../models/user");
const bcrypt = require("bcryptjs");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");

//Create Account
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, phoneNumber, email, password ,position} = req.body;
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
      .status(400)
      .json({ msg: "User already exists" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    let user = new User({
      name,
      email,
      phoneNumber,
      password: hashedPassword,
      position,
    });
    user = await user.save();
    res.json(user);
  } catch (err) {
    console.log(err);
    res.status(500).json({ error: err.message });
  }
});

// Login
authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exist" });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Invalid credentials" });
    }
    const token = jwt.sign({ _id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
  } catch (err) {
    console.log(err);
    res.status(500).json({ error: err.message });
  }
});

authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);
    const verified = jwt.verify(token, "passwordKey");
    if (!verified) return res.json(false);

    const user = await User.findById(verified._id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

// Update user profile
authRouter.put("/api/updateProfile", auth, async (req, res) => {
  try {
    const { name,email, phoneNumber, position, password } = req.body;
    const userId = req.user;

    let updatedFields = { name, password, phoneNumber, position };
    
    if (phoneNumber.length !== 10) {
      return res.status(400).json({ msg: "Phone number must be 10 digits long" });
    }
    if (password) {
      const hashedPassword = await bcrypt.hash(password, 10);
      updatedFields.password = hashedPassword;
    }

    const updatedUser = await User.findByIdAndUpdate(userId, updatedFields, { new: true });

    res.json(updatedUser);
  } catch (err) {
    console.log(err);
    res.status(500).json({ error: err.message });
  }
});

// Get all users
authRouter.get("/api/users", async (req, res) => {
  try {
    const users = await User.find();
    res.json(users);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
});

// Get Specific User's Tasks
authRouter.get("/api/userTasks/:userId", auth, async (req, res) => {
  try {
    const userId = req.params.userId;

    if (!userId) {
      return res.status(400).json({ msg: "User ID parameter is required" });
    }

    const tasks = await Task.find({ uid: userId });

    res.json(tasks);
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: "Server Error" });
  }
});

module.exports = authRouter;
