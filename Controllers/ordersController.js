const connection = require("../database/connection");
const { sendOrderEmails } = require("../services/emailService");

const createOrder = (req, res) => {
  const {
    items,
    promotion_id,
    firstName,
    lastName,
    email,
    street,
    houseNumber,
    city,
    state,
    postalCode,
    country,
  } = req.body;

  const shippingCost = 5.0;

  if (!items || items.length === 0) {
    return res.status(400).json({ error: "Carrello vuoto" });
  }

  const ids = items.map((i) => i.product_id);
  const sqlProducts = `SELECT product_id, name, price FROM products WHERE product_id IN (?)`;

  connection.query(sqlProducts, [ids], (err, products) => {
    if (err) return res.status(500).json({ error: "Errore database prodotti" });

    let subtotal = 0;
    items.forEach((item) => {
      const prod = products.find((p) => p.product_id === item.product_id);
      if (prod) subtotal += prod.price * item.quantity;
    });

    const applyPromotion = (callback) => {
      if (!promotion_id)
        return callback(null, {
          finalTotal: subtotal + shippingCost,
          promoId: null,
        });

      const sqlDiscount = `SELECT * FROM discount WHERE promotion_id = ? AND active = true`;
      connection.query(sqlDiscount, [promotion_id], (err, resu) => {
        if (err) return callback(err);
        let discountAmount = 0;
        let foundPromoId = null;

        if (resu.length > 0) {
          const d = resu[0];
          foundPromoId = d.promotion_id;
          discountAmount =
            d.discount_type === "percentage"
              ? (subtotal * d.discount_value) / 100
              : d.discount_value;
        }
        const finalTotal =
          subtotal - Math.min(discountAmount, subtotal) + shippingCost;
        callback(null, { finalTotal, promoId: foundPromoId });
      });
    };

    applyPromotion((err, promoRes) => {
      if (err) return res.status(500).json({ error: "Errore calcolo sconto" });

      const sqlOrder = `
        INSERT INTO orders 
        (date, total_amount, status, promotion_id, email, first_name, last_name, street, house_number, city, state, postal_code, country)
        VALUES (CURDATE(), ?, 'pending', ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      `;

      const orderDataArray = [
        promoRes.finalTotal,
        promoRes.promoId,
        email,
        firstName,
        lastName,
        street,
        houseNumber,
        city,
        state,
        postalCode,
        country,
      ];

      connection.query(sqlOrder, orderDataArray, (err, orderRes) => {
        if (err) {
          console.error("ERRORE INSERT ORDINE:", err);
          return res.status(500).json({
            error: "Errore database durante l'inserimento ordine",
            details: err.message,
          });
        }

        const orderId = orderRes.insertId;
        const sqlItem = `INSERT INTO order_item (order_id, product_id, quantity, price) VALUES ?`;
        const values = items.map((item) => {
          const prod = products.find((p) => p.product_id === item.product_id);
          return [orderId, item.product_id, item.quantity, prod.price];
        });

        connection.query(sqlItem, [values], async (err) => {
          if (err) {
            console.error("ERRORE ITEMS:", err);
            return res
              .status(500)
              .json({ error: "Errore inserimento prodotti" });
          }

          const orderDataForEmail = {
            order_id: orderId,
            date: new Date().toLocaleDateString("it-IT"),
            total_amount: promoRes.finalTotal,
            first_name: firstName,
            last_name: lastName,
            email: email,
            street: street,
            house_number: houseNumber,
            city: city,
            state: state,
            postal_code: postalCode,
            country: country,
            free_shipping: false,
          };

          const emailItems = items.map((item) => {
            const prod = products.find((p) => p.product_id === item.product_id);
            return {
              name: prod ? prod.name : "Prodotto",
              quantity: item.quantity,
              price: prod ? prod.price : 0,
            };
          });

          try {
            await sendOrderEmails(orderDataForEmail, emailItems);
            console.log(`Email inviate con successo per l'ordine #${orderId}`);
          } catch (e) {
            console.error("Errore durante l'invio delle email: ", e);
          }

          res.json({
            ok: true,
            order_id: orderId,
            total: promoRes.finalTotal,
          });
        });
      });
    });
  });
};

module.exports = { createOrder };
