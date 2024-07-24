const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require('body-parser');

const app = express();
const DB = "your db link";

const authRouter = require("./routes/auth");
const taskRouter = require("./routes/task");

app.use(express.json());
app.use(bodyParser.json());
app.use(authRouter);
app.use(taskRouter);

mongoose
  .connect(DB)
  .then(() => console.log("Connected to MongoDB"))
  .catch((err) => console.log(err));

app.listen(3000, "0.0.0.0", () => console.log("Server running on port 3000"));

