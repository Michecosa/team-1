const connection = require("../database/connection");

const validateDiscount = (req, res) => {
  const { promo_code, subtotal } = req.body;

  if (!promo_code || promo_code.trim() === "") {
    return res.json({
      valid: false,
      discount: 0,
      total: subtotal,
    });
  }

  const sql = `
    SELECT *
    FROM discount
    WHERE promo_code = ?
      AND active = true
      AND CURDATE() BETWEEN start_date AND end_date
  `;

  connection.query(sql, [promo_code], (err, results) => {
    if (err) {
      return res.status(500).json({ error: "Errore database" });
    }

    if (results.length === 0) {
      return res.status(404).json({ error: "Codice non valido o scaduto" });
    }

    const discountRow = results[0];
    let discountAmount = 0;

    if (discountRow.discount_type === "percentage") {
      discountAmount = (subtotal * discountRow.discount_value) / 100;
    } else {
      discountAmount = discountRow.discount_value;
    }

    // Evita totali negativi, figurati se siamo noi a pagare a loro
    discountAmount = Math.min(discountAmount, subtotal);

    const totalAfterDiscount = subtotal - discountAmount;

    res.json({
      valid: true,
      discount: discountAmount,
      total: totalAfterDiscount,
      discount_id: discountRow.promotion_id,
    });
  });
};

module.exports = { validateDiscount };
