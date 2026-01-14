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
    <div style="max-width:600px; margin:0 auto;
      padding:30px; font-family:Arial, Helvetica, sans-serif; 
      color:#333; background-color:#ffffff; line-height:1.6;">
      <h2 style="text-align:center; letter-spacing:1px;">
        Welcome to <span style="font-weight:700;">DUALIA</span>
      </h2>
      <p style="text-align:center; font-size:15px;">
        We are delighted to welcome you to a place where quality, style,
        and attention to detail come together to create a refined and
        seamless shopping experience.
      </p>
      <div style="text-align:center; margin:30px 0;">
        <img src="http://localhost:3000/logo_dualia_welcome.jpeg" alt="DUALIA logo" style="max-width:160px;" />
      </div>
      <p>
        Every product in our collection is carefully selected to meet the
        highest standards of design, reliability, and value.
        We believe that online shopping should be more than just convenient —
        it should be inspiring, enjoyable, and trustworthy.
      </p>
      <p>
        Take your time to explore our curated collections, discover the latest
        arrivals, and experience the difference that true quality makes.
        Your next exceptional purchase is waiting for you, just a few clicks away.
      </p>
      <div style={{textAlign: 'center', padding: '30px', backgroundColor: '#f9f9f9', borderRadius: '12px', border: '1px solid #eee', margin: '40px 0'}}>
        <h3 style={{ margin: '0 0 10px 0', fontSize: '20px' }}>Special Welcome Gift</h3>
        <p style={{ fontSize: '15px', margin: '0 0 20px 0' }}>
         To celebrate your arrival, we have reserved a 
         <strong>10% discount</strong> 
         for you to use on your first order!
        </p>
        <div style={{display: 'inline-block', padding: '15px 30px', border: '2px dashed #333', borderRadius: '8px', marginBottom: '10px'}}>
         <span style={{ fontSize: '22px', fontWeight: 'bold', letterSpacing: '2px' }}>WELCOME10</span>
        </div>
        <div style={{ fontSize: '12px', color: '#888', marginTop: '5px' }}>
         Valid until: 31/12/2026
        </div>
        <p style={{ fontSize: '14px', marginTop: '20px', color: '#666' }}>
         Enter the code at checkout to apply the reduction.
        </p>
        <a href="/" style={{display: 'inline-block', marginTop: '15px', padding: '12px 40px', backgroundColor: '#000', color: '#fff', textDecoration: 'none', fontWeight: 'bold', borderRadius: '5px', fontSize: '14px'}}>
         SHOP NOW
        </a>
      </div>
      <p style="text-align:center; margin:30px 0; font-size:16px; font-weight:500;">
        Begin your journey into shopping redefined.
      </p>

      <hr style="border:none; border-top:1px solid #eee; margin:30px 0;" />

      <p style="text-align:center; font-size:13px; color:#666;">For any support, feel free to contact us.</p>
      <p style="text-align:center; font-weight:600; margin-top:10px;">— Team DUALIA</p>
    </div>
  `
      ,
    });

    res.status(200).json({ message: "Email inviata (Mailtrap)" });
  } catch (error) {
    console.error("Errore invio email:", error);
    res.status(500).json({ message: "Errore durante l'invio" });
  }
};
