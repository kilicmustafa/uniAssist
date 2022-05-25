package com.uniassist.services;

import com.sendgrid.*;

import java.io.IOException;

public class MailService {

    private final String email = "info@uni-assist.com";
    private final String API_KEY = "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";
    private Email from;
    private SendGrid sendGrid;

    public MailService() {
        from = new Email(email);
        sendGrid = new SendGrid(API_KEY);
    }

    public void sendActivationMail(final String mailAddress, final String headline, final String msg) {
        sendMail(mailAddress, headline, "text/plain", msg);
    }

    public void sendRemindMail(String email) {
        this.sendMail(email, "Uni-Assist, A Remind",  "text/html", "<div style=\"overflow: hidden;\"><font size=\"3\"><div dir=\"ltr\">\n" +
                "<p style=\"margin-bottom:0in;background:transparent\">\n" +
                "<font face=\"Times New Roman, serif\"><b>Uni-Assist Registration</b></font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\">Thank\n" +
                "you for your registration! Please submit your documents at the online\n" +
                "portal, in order to get your application checked.</font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\">Please\n" +
                "press the Button bellow “Edit Information”. Go to “Application\n" +
                "Settings” above. Choose your wanted degree program and type of\n" +
                "application. Afterwards choose the country, where you finished High\n" +
                "School and got your school diploma. At the end a list of the required\n" +
                "documents will be displayed. Then you will have the option to submit\n" +
                "your documents. After you submitted all the needed documents we\n" +
                "will contact you within a short period of time.</font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\"><b>Our\n" +
                "task: (How we can help you)</b></font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\">We\n" +
                "help you with making the application proccess at german universities\n" +
                "easier for you. We check if your application is complete. We will\n" +
                "also inform you, if any document misses, so that your university\n" +
                "application will be accepted later.</font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\">We\n" +
                "also convert you school or university grades into the german ones, so\n" +
                "that they can be equivalent to the german grade system.</font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\">Furthermore,\n" +
                "we recommend you universities, where you have better chances of\n" +
                "getting an university admission to the wanted degree program.</font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\">The\n" +
                "service fee is 50,00€</font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\"><b>Navigation\n" +
                "steps for a successful application:</b></font></p>\n" +
                "<ol>\n" +
                "<li><p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\">Submit\n" +
                "your documents.</font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"></p>\n" +
                "</li><li><p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\">All\n" +
                "the application documents will be carefully checked by our team. We\n" +
                "will inform you, if your application is complete, so that your\n" +
                "university application will be accepted later.</font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"></p>\n" +
                "</li><li><p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\">If\n" +
                "your application is complete, you will receive an e-mail with\n" +
                "confirmation. The service fee has to be transferred to the following\n" +
                "bank account:</font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"></p>\n" +
                "</li></ol>\n" +
                "<p style=\"margin-left:0.25in;margin-bottom:0in;line-height:0.23in;background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n" +
                "<font color=\"#000000\"><font face=\"Times New Roman, serif\"><font style=\"font-size:10pt\">Account\n" +
                "Holder: Rheinland Privatschule</font></font></font></p>\n" +
                "<p style=\"margin-left:0.25in;margin-bottom:0in;line-height:0.23in;background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n" +
                "<font color=\"#000000\"><font face=\"Times New Roman, serif\"><font style=\"font-size:10pt\">Bank:\n" +
                "Deutsche Bank Essen</font></font></font></p>\n" +
                "<p lang=\"en-US\" style=\"margin-left:0.25in;margin-bottom:0in;line-height:0.23in;background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n" +
                "<font color=\"#000000\"><font face=\"Times New Roman, serif\"><font style=\"font-size:10pt\">Account\n" +
                "Nr.: 150 451 300</font></font></font></p>\n" +
                "<p lang=\"en-US\" style=\"margin-left:0.25in;margin-bottom:0in;line-height:0.23in;background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n" +
                "<font color=\"#000000\"><font face=\"Times New Roman, serif\"><font style=\"font-size:10pt\">BLZ:\n" +
                "360 700 24</font></font></font></p>\n" +
                "<p lang=\"en-US\" style=\"margin-left:0.25in;margin-bottom:0in;line-height:0.23in;background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n" +
                "<font color=\"#000000\"><font face=\"Times New Roman, serif\"><font style=\"font-size:10pt\">Swift-Bic:\n" +
                "DEUTDEDBESS</font></font></font></p>\n" +
                "<p style=\"margin-left:0.25in;margin-bottom:0in;background:transparent\"><font color=\"#000000\"><font face=\"Times New Roman, serif\"><font style=\"font-size:10pt\">IBAN-Code:\n" +
                "DE56 3607 0024 0150 4513 00</font></font></font></p>\n" +
                "<p style=\"margin-left:0.25in;margin-bottom:0in;background:transparent\"><font color=\"#000000\"><font face=\"Times New Roman, serif\"><font style=\"font-size:10pt\">Refence:\n" +
                "Uni Assist.com / Your Name</font></font></font></p>\n" +
                "<ol start=\"4\">\n" +
                "<li><p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\">Afterwards,\n" +
                "you get a recommendation letter by our team with your converted\n" +
                "school grades and a list of universities, where you can apply for\n" +
                "the desired degree program. We give you also information if your\n" +
                "application is complete or if have to submit any other documents.\n" +
                "Furthermore, you receive important information about how to prepare\n" +
                "your original documents.</font></p></li></ol>\n" +
                "<p lang=\"en-US\" align=\"left\" style=\"margin-left:0.25in;margin-bottom:0in;border:none;padding:0in;font-variant-numeric:normal;font-variant-east-asian:normal;line-height:0.23in;background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n" +
                "<font color=\"#000000\"><font face=\"Times New Roman, serif\"><font style=\"font-size:10pt\"><b>Uni-Assist\n" +
                "Anmeldung</b></font></font></font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\">Vielen\n" +
                "Dank für die Registrierung. Damit wir Ihre Bewerbung bearbeiten\n" +
                "können, laden Sie bitte Ihre Unterlagen in unserem Online-Portal\n" +
                "hoch.</font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\">Klicken\n" +
                "Sie bitte unten den Button „Informationen Bearbeiten“. Gehen Sie\n" +
                "oben auf „Bewerbung Einstellungen“. Wählen Sie erst Ihren Wunsch\n" +
                "und dann die Bewerbungsart. Wählen Sie bitte anschließend Ihr Land\n" +
                "aus. Im Anschluss wird die Liste von benötigen Unterlagen eröffnet.\n" +
                "Auf diesem Portal können Sie Ihre Unterlagen hochladen.</font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\">Nachdem\n" +
                "Sie Ihre Unterlagen hochgeladen haben, melden wir uns bei Ihnen in\n" +
                "kürzer Zeit.</font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\"><b>Unsere\n" +
                "Aufgabe:</b></font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\">Wir\n" +
                "erleichtern Ihren Bewerbungsprozess an deutschen Universitäten. Wir\n" +
                "überprüfen Ihre Unterlagen und folglich teilen wir Ihnen mit, ob\n" +
                "die Unterlagen vollständig bzw. im richtigen Format sind.</font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\">Wir\n" +
                "rechnen Ihre bisherigen Schul- bzw. Studienleistungen ins deutsche\n" +
                "Notensystem um.</font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\">Im\n" +
                "Anschluss empfehlen wir Ihnen die Universitäten, wo Sie die höhere\n" +
                "Chance haben, um eine Zulassung zum gewünschten Studiengang zu\n" +
                "bekommen.</font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\">Dieses\n" +
                "Service kostet 50 Euro.</font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\"><b>Bewerbungsschritte:</b></font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\">1-\n" +
                "Laden Sie Ihre Unterlagen erst hoch.</font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\">2-\n" +
                "Die Unterlagen werden von uns sorgfältig überprüfen. Falls wir\n" +
                "noch weitere Unterlagen benötigen, teilen wir Ihnen dies mit.</font></p>\n" +
                "<p style=\"margin-bottom:0in;background:transparent\"><font face=\"Times New Roman, serif\">4-\n" +
                "Falls alle Unterlagen vollständig sind, bestätigen wir dies bei\n" +
                "Ihnen erst per Mail. Anschließend wird die Bearbeitungsgebühr in\n" +
                "Höhe von 50 Euro auf das folgende Konto überwiesen:</font></p>\n" +
                "<p align=\"left\" style=\"margin-bottom:0in;border:none;padding:0in;font-variant-numeric:normal;font-variant-east-asian:normal;line-height:0.23in;background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n" +
                "<font color=\"#000000\"><font face=\"Times New Roman, serif\"><font style=\"font-size:10pt\">Kontoinhaber:\n" +
                "Rheinland Privatschule</font></font></font></p>\n" +
                "<p align=\"left\" style=\"margin-bottom:0in;border:none;padding:0in;font-variant-numeric:normal;font-variant-east-asian:normal;line-height:0.23in;background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n" +
                "<font color=\"#000000\"><font face=\"Times New Roman, serif\"><font style=\"font-size:10pt\">Bank:\n" +
                "Deutsche Bank Essen</font></font></font></p>\n" +
                "<p align=\"left\" style=\"margin-bottom:0in;border:none;padding:0in;font-variant-numeric:normal;font-variant-east-asian:normal;line-height:0.23in;background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n" +
                "<font color=\"#000000\"><font face=\"Times New Roman, serif\"><font style=\"font-size:10pt\">Konto\n" +
                "Nr.: 150 451 300</font></font></font></p>\n" +
                "<p align=\"left\" style=\"margin-bottom:0in;border:none;padding:0in;font-variant-numeric:normal;font-variant-east-asian:normal;line-height:0.23in;background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n" +
                "<font color=\"#000000\"><font face=\"Times New Roman, serif\"><font style=\"font-size:10pt\">BLZ:\n" +
                "360 700 24</font></font></font></p>\n" +
                "<p align=\"left\" style=\"margin-bottom:0in;border:none;padding:0in;font-variant-numeric:normal;font-variant-east-asian:normal;line-height:0.23in;background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n" +
                "<font color=\"#000000\"><font face=\"Times New Roman, serif\"><font style=\"font-size:10pt\">Swift-Bic:\n" +
                "DEUTDEDBESS</font></font></font></p>\n" +
                "<p align=\"left\" style=\"margin-bottom:0in;border:none;padding:0in;font-variant-numeric:normal;font-variant-east-asian:normal;line-height:0.23in;background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n" +
                "<font color=\"#000000\"><font face=\"Times New Roman, serif\"><font style=\"font-size:10pt\">IBAN-Code:\n" +
                "DE56 3607 0024 0150 4513 00</font></font></font></p>\n" +
                "<p align=\"left\" style=\"margin-bottom:0in;border:none;padding:0in;font-variant-numeric:normal;font-variant-east-asian:normal;line-height:0.23in;background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n" +
                "<font color=\"#000000\"><font face=\"Times New Roman, serif\"><font style=\"font-size:10pt\">Verwendungszweck:\n" +
                "Uni Assist.com / Ihr Name</font></font></font></p>\n" +
                "<p align=\"left\" style=\"margin-bottom:0in;border:none;padding:0in;font-variant-numeric:normal;font-variant-east-asian:normal;line-height:0.23in;background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n" +
                "<font color=\"#000000\"><font face=\"Times New Roman, serif\"><font style=\"font-size:10pt\">5-\n" +
                "Im Anschluss bekommen Sie von uns ein Empfehlungsschreiben mit der\n" +
                "umgerechneten Note und eine Liste von Universitäten, wo Sie sich\n" +
                "bewerben können. Wir teilen in diesem Schreiben auch mit, ob die\n" +
                "Unterlagen vollständig und in welcher Form angefertigt werden\n" +
                "sollen.</font></font></font></p></div>\n" +
                "</font></div>");
    }

    public void sendMail(final String mailAddress, final String headline, final String contentType, final String msg) {
        Content content = new Content(contentType, msg);
        Email to = new Email(mailAddress);
        Mail mail = new Mail(from, headline, to, content);
        Request request = new Request();
        try {
            request.setMethod(Method.POST);
            request.setEndpoint("mail/send");
            request.setBody(mail.build());
            Response response = sendGrid.api(request);
            System.out.println(response.getStatusCode());
            System.out.println(response.getBody());
            System.out.println(response.getHeaders());
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }
}
