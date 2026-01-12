const connection = require("../database/connection");

const index = (req, res) => {
  const sql = "SELECT * FROM products";
  connection.query(sql, (err, resu) => {
    if (err) {
      return res.status(500).json({
        error: "il database ha fallito",
      });
    }
    res.json(resu);
  });
};

const show = (req, res) => {
  const id = req.params.id;
  const sql = "SELECT * FROM products WHERE product_id = ?";
  connection.query(sql, [id], (err, resu) => {
    if (err)
      return res.status(500).json({
        error: "problemi con il server",
      });
    if (resu.length === 0)
      return res.status(404).json({ error: "prodotto inesistente" });
    const prodotto = resu[0];
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
    if (err) {
      return res.status(500).json({
        error: "errore nella query di ricerca",
      });
    }
    res.json(results);
  });
};

module.exports = {
  index,
  show,
  search,
};
