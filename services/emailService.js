require("dotenv").config();
const nodemailer = require("nodemailer");

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

const transport = nodemailer.createTransport({
  host: "sandbox.smtp.mailtrap.io",
  port: 2525,
  auth: {
    user: process.env.MAILTRAP_USER,
    pass: process.env.MAILTRAP_PASS,
  },
});

const sendOrderEmails = async (order, items) => {
  const rowsHtml = items
    .map(
      (i) => `
        <tr>
          <td>${i.name}</td>
          <td align="center">${i.quantity}</td>
          <td align="right">€${i.price}</td>
        </tr>
      `
    )
    .join("");

  try {
    await transport.sendMail({
      from: '"Shop" <orders@test.com>',
      to: "venditore@test.com",
      subject: `Nuovo ordine #${order.order_id}`,
      html: `
        <h2>Nuovo ordine ricevuto</h2>
        <p><strong>Ordine:</strong> #${order.order_id}</p>
        <p><strong>Cliente:</strong> ${order.first_name} ${order.last_name}</p>
        <p><strong>Email:</strong> ${order.email}</p>
        <p><strong>Totale:</strong> €${order.total_amount}</p>
      `,
    });
  } catch (err) {
    console.error("Errore invio email venditore:", err);
  }

  await sleep(10_000);

  try {
    await transport.sendMail({
      from: '"Shop" <orders@test.com>',
      to: order.email,
      subject: `Conferma ordine #${order.order_id}`,
      html: `
        <h2>Conferma ordine #${order.order_id}</h2>

        <p>
          Ciao ${order.first_name} ${order.last_name},<br/>
          abbiamo ricevuto il tuo ordine del ${order.date}.
        </p>

        <table width="100%" cellpadding="6" cellspacing="0" border="1">
          <thead>
            <tr>
              <th align="left">Prodotto</th>
              <th>Qtà</th>
              <th align="right">Prezzo</th>
            </tr>
          </thead>
          <tbody>
            ${rowsHtml}
          </tbody>
        </table>

        <p><strong>Totale:</strong> €${order.total_amount}</p>

        ${
          order.free_shipping
            ? "<p><strong>Spedizione gratuita</strong></p>"
            : ""
        }

        <h4>Indirizzo di spedizione</h4>
        <p>
          ${order.street}, ${order.house_number}<br/>
          ${order.postal_code} ${order.city} (${order.state})<br/>
          ${order.country}
        </p>
      `,
    });
  } catch (err) {
    console.error("Errore invio email cliente:", err);
  }
};

module.exports = { sendOrderEmails };
