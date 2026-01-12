const connection = require("../database/connection");

const createOrder = (req, res) => {
  const { items, user } = req.body;

  if (!items || items.length === 0) {
    return res.status(400).json({ error: "carrello vuoto" });
  }

  const ids = items.map((i) => i.product_id);

  const sqlProducts = `
    SELECT product_id, price 
    FROM products
    WHERE product_id IN (?)
  `;

  connection.query(sqlProducts, [ids], (err, products) => {
    if (err) return res.status(500).json({ error: "errore db prod" });

    let total = 0;
    items.forEach((item) => {
      const prod = products.find((p) => p.product_id === item.product_id);
      total += prod.price * item.quantity;
    });

    const sqlOrder = `
        INSERT INTO orders 
        (date, total_amount, status, promotion_id, free_shipping, email, first_name, last_name, street, house_number, city, state, postal_code, country)
        VALUES (CURDATE(), ?, 'pending', NULL, FALSE, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;

    const userData = [
      total,
      user.email,
      user.first_name,
      user.last_name,
      user.street,
      user.house_number,
      user.city,
      user.state,
      user.postal_code,
      user.country,
    ];

    connection.query(sqlOrder, userData, (err, orderRes) => {
      if (err)
        return res.status(500).json({ error: "errore creazione ordine" });

      const orderId = orderRes.insertId;

      const sqlItem = `
        INSERT INTO order_item (order_id, product_id, quantity, price)
        VALUES ?
      `;

      const values = items.map((item) => {
        const prod = products.find((p) => p.product_id === item.product_id);
        return [orderId, item.product_id, item.quantity, prod.price];
      });

      connection.query(sqlItem, [values], (err) => {
        if (err) return res.status(500).json({ error: "errore items" });

        res.json({
          ok: true,
          order_id: orderId,
          total,
        });
      });
    });
  });
};

module.exports = {
  createOrder,
};
