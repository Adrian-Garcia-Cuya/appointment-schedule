import {logger} from "firebase-functions";
import {onDocumentCreated} from "firebase-functions/firestore";
import {sendAppointmentEmail} from "./services/emailService";

export const onAppointmentCreated = onDocumentCreated(
  "appointment/{appointmentId}",
  async (event) => {
    logger.log("Appointment created", event);

    const snapshot = event.data;
    if (!snapshot) {
      logger.error("No data in appointment");
      return;
    }
    const appointment = snapshot.data();

    try {
      await sendAppointmentEmail({
        title: appointment.title,
        description: appointment.description,
        email: appointment.email,
        date: appointment.date,
      });
    } catch (error) {
      logger.error("Error processing appointment:", error);
    }
  },
);
