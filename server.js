const express = require("express");
const app = express();
const PORT = 3000;
const productsRouter = require("./Routers/productsRouter");
const ordersRouter = require("./Routers/ordersRouter");
const emailsRouter = require("./Routers/emailsRouter");
const notFound = require("./middlewares/notFound");
const errorHandler = require("./middlewares/errorHandler");
const cors = require("cors");

app.use(
  cors({
    origin: "http://localhost:5173",
  })
);

app.use(express.json());
app.use(express.static("public"));
app.get("/", (req, res) => {
  res.send("home page");
});

app.get("/errore", (req, res) => {
  throw new Error("Errore di test");
});

app.use("/api/products", productsRouter);
app.use("/api/emails", emailsRouter);
app.use("/orders", ordersRouter);

app.use(notFound);
app.use(errorHandler);

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
