require("dotenv").config();
const nodemailer = require("nodemailer");

// MailTrap
var transport = nodemailer.createTransport({
  host: "sandbox.smtp.mailtrap.io",
  port: 2525,
  auth: {
    user: process.env.MAILTRAP_USER,
    pass: process.env.MAILTRAP_PASS,
  },
});

exports.sendNewsletterEmail = async (req, res) => {
  const { email } = req.body;

  if (!email) {
    return res.status(400).json({ message: "Email mancante" });
  }

  try {
    await transport.sendMail({
      from: '"Newsletter" <newsletter@test.com>',
      to: email,
      subject: "Iscrizione alla newsletter",
      html: `
        <h2>Iscrizione confermata</h2>
        <p>Da ora fai parte della nostra newsletter!</p>
      `,
    });

    res.status(200).json({ message: "Email inviata (Mailtrap)" });
  } catch (error) {
    console.error("Errore invio email:", error);
    res.status(500).json({ message: "Errore durante l'invio" });
  }
};
