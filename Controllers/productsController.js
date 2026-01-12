const connection = require("../database/connection");

const addImageExtension = (product) => {
  return {
    ...product,
    url_image: "http://localhost:3000/" + product.url_image + ".jpeg",
  };
};

const index = (req, res) => {
  const sql = "SELECT * FROM products";
  connection.query(sql, (err, resu) => {
    if (err) {
      return res.status(500).json({ error: "il database ha fallito" });
    }
    const prodotti = resu.map(addImageExtension);
    res.json(prodotti);
  });
};

const show = (req, res) => {
  const id = req.params.id;
  const sql = "SELECT * FROM products WHERE product_id = ?";
  connection.query(sql, [id], (err, resu) => {
    if (err) return res.status(500).json({ error: "problemi con il server" });
    if (resu.length === 0)
      return res.status(404).json({ error: "prodotto inesistente" });
    const prodotto = addImageExtension(resu[0]);
    res.json(prodotto);
  });
};

const search = (req, res) => {
  const term = req.query.search || "";

  const sql = `
    SELECT *
    FROM products
    WHERE name LIKE ? 
       OR description LIKE ?
  `;

  connection.query(sql, [`%${term}%`, `%${term}%`], (err, results) => {
    if (err)
      return res.status(500).json({ error: "errore nella query di ricerca" });
    const prodotti = results.map(addImageExtension);
    res.json(prodotti);
  });
};

module.exports = { index, show, search };
