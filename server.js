const express = require("express");
const app = express();
const PORT = 3000;
const productsRouter = require("./Routers/productsRouter");
const ordersRouter = require("./Routers/ordersRouter");
const emailsRouter = require("./Routers/emailsRouter");
const cors = require("cors");

app.use(
  cors({
    origin: "http://localhost:5173",
  })
);

//da controllare
app.use(express.json({}));

//uso della cartella public
app.use(express.static("public"));

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});

app.get("/", (req, res) => {
  res.send("home page");
});

app.use("/api/products", productsRouter);
app.use("/api/emails", emailsRouter);
app.use("/orders", ordersRouter);
