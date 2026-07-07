import * as nodemailer from "nodemailer";
import * as ics from "ics";
import * as logger from "firebase-functions/logger";

interface AppointmentEmailData {
  title: string;
  description: string;
  email: string;
  date: { toDate: () => Date };
}

export async function sendAppointmentEmail(
  data: AppointmentEmailData,
): Promise<void> {
  const date = data.date.toDate();

  const transporter = nodemailer.createTransport({
    host: process.env.SMTP_HOST || "smtp.gmail.com",
    port: parseInt(process.env.SMTP_PORT || "465"),
    secure: process.env.SMTP_SECURE === "true",
    auth: {
      user: process.env.SMTP_USER,
      pass: process.env.SMTP_PASS,
    },
  });

  const event: ics.EventAttributes = {
    start: [
      date.getFullYear(),
      date.getMonth() + 1,
      date.getDate(),
      date.getHours(),
      date.getMinutes(),
    ],
    duration: {hours: 1, minutes: 0},
    title: data.title,
    description: data.description,
    status: "CONFIRMED",
    busyStatus: "BUSY",
  };

  const icsContent = await new Promise<string>((resolve, reject) => {
    ics.createEvent(event, (error, value) => {
      if (error) reject(error);
      resolve(value);
    });
  });

  const htmlRows = [
    "<div style=\"font-family: Arial, sans-serif; padding: 20px;\">",
    "<h2>¡Tu cita ha sido agendada!</h2>",
    "<p>Hola,</p>",
    "<p>Te confirmamos que hemos registrado tu cita:</p>",
    "<table style=\"border-collapse: collapse; width: 100%; max-width: 400px;\">",
    "<tr>",
    "<td style=\"padding: 8px; font-weight: bold; width: 110px;\">Asunto:</td>",
    `<td>${data.title}</td>`,
    "</tr>",
    "<tr>",
    "<td style=\"padding: 8px; font-weight: bold;\">Fecha y Hora:</td>",
    `<td>${date.toLocaleString("es-ES", {timeZone: "America/Lima"})}</td>`,
    "</tr>",
    "<tr>",
    "<td style=\"padding: 8px; font-weight: bold;\">Notas:</td>",
    `<td>${data.description || "Sin descripción"}</td>`,
    "</tr>",
    "</table>",
    "<p>Adjunto encontrarás un archivo de calendario.</p>",
    "</div>",
  ].join("");

  const mailOptions = {
    from: "\"Agenda de Citas\" <onboarding@resend.dev>",
    to: data.email,
    subject: `Confirmación de tu cita: ${data.title}`,
    html: htmlRows,
    attachments: [
      {
        filename: "evento-cita.ics",
        content: icsContent,
        contentType: "text/calendar",
      },
    ],
  };

  await transporter.sendMail(mailOptions);
  logger.log(`Correo enviado exitosamente a ${data.email}`);
}
