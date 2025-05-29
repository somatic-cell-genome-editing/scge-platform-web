package edu.mcw.scge.controller;

import com.sun.mail.smtp.SMTPTransport;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.mail.Message;
import jakarta.mail.Session;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.util.Date;
import java.util.Properties;

@Controller
@RequestMapping("/data")
public class FeedbackController {
    @RequestMapping(value="/feedback")
    public String getFeedback(HttpServletRequest req, HttpServletResponse res, Model model) throws Exception {

        StringBuilder buffer = new StringBuilder();
        try(BufferedReader reader = req.getReader();) {
            String line;
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
                buffer.append(System.lineSeparator());
            }
            if (!buffer.toString().isEmpty()) {
                JSONObject obj = new JSONObject(buffer.toString());


                String email = (String) obj.get("email");
                String feedbackMsg = (String) obj.get("message");
                String page = (String) obj.get("webPage");

//                FeedbackDao fdao = new FeedbackDao();
//                fdao.insert(email, feedbackMsg, page);

                System.out.println(email+feedbackMsg+page);
                String smtpHost = "smtp.mcw.edu";

                // Get a Properties object
                Properties props = System.getProperties();

                props.setProperty("mail.smtp.host", "smtp.mcw.edu");
                props.setProperty("mail.smtp.port", "25");

                Session session = Session.getInstance(props, null);

                // -- Create a new message --
                final MimeMessage msg = new MimeMessage(session);

                // -- Set the FROM and TO fields --
                msg.setFrom(new InternetAddress("scge_platform@mcw.edu", "SCGE Platform"));

                msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse("scge_toolkit@mcw.edu", false));
//                msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse("akundurthi@mcw.edu", false));

                //msg.setRecipients(Message.RecipientType.BCC, InternetAddress.parse("jdepons@mcw.edu", false));

                msg.setSubject("SCGE Platform Feedback Request");


                String emailBody = "";

                emailBody += "\n\nFeedback message received from :\t" + email + "\n\n";
                emailBody += feedbackMsg + "\n\n";
                emailBody += "This message was sent from :\t" + page + "\n\n";


                msg.setText(emailBody, "utf-8");
                msg.setSentDate(new Date());

                SMTPTransport t = (SMTPTransport) session.getTransport("smtp");

                t.connect();
                t.sendMessage(msg, msg.getAllRecipients());
                t.close();

            }
        }

       return null;
    }

}
