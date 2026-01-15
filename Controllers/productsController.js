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
  const { category, color, sale, order, minPrice, maxPrice, q } = req.query;

  let sql = `
    SELECT DISTINCT p.*
    FROM products p
    LEFT JOIN category c ON p.category_id = c.category_id
    WHERE 1=1
  `;
  const params = [];

  if (q?.trim()) {
    sql += " AND (p.name LIKE ? OR p.description LIKE ?)";
    const searchVal = `%${q}%`;
    params.push(searchVal, searchVal);
  }

  if (category) {
    sql += " AND c.name = ?";
    params.push(category);
  }
  if (color) {
    sql += " AND p.color = ?";
    params.push(color);
  }

  if (sale === "yes") sql += " AND p.price < p.full_price";
  else if (sale === "no") sql += " AND p.price = p.full_price";

  if (minPrice && !isNaN(minPrice)) {
    sql += " AND p.price >= ?";
    params.push(Number(minPrice));
  }
  if (maxPrice && !isNaN(maxPrice)) {
    sql += " AND p.price <= ?";
    params.push(Number(maxPrice));
  }
  const orderMap = {
    price_asc: "p.price ASC",
    price_desc: "p.price DESC",
    name_asc: "p.name ASC",
    name_desc: "p.name DESC",
  };

  if (orderMap[order]) {
    sql += ` ORDER BY ${orderMap[order]}`;
  }

  connection.query(sql, params, (err, results) => {
    if (err) return res.status(500).json({ error: "Errore database" });
    res.json(results.map(addImageExtension));
  });
};

module.exports = { index, show, search };
