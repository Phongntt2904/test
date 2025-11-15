package util;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtility {

    public static void sendEmail(String toAddress, String subject, String messageContent) {
        
        // 1. Cấu hình Server Gmail (Chuẩn 100%)
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // 2. TÀI KHOẢN GMAIL CỦA BẠN
        // Thay email của bạn vào đây
        final String myEmail = "phongntt195@gmail.com"; 
        
        // Dán chuỗi 16 ký tự vừa copy vào đây (xóa hết khoảng trắng nếu có)
        final String myPassword = "uniz gswa surw jedx"; 

        // 3. Đăng nhập
        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(myEmail, myPassword);
            }
        });

        try {
            // 4. Tạo nội dung email
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(myEmail));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toAddress));
            msg.setSubject(subject);
            msg.setContent(messageContent, "text/html; charset=UTF-8"); // Gửi dạng HTML đẹp

            // 5. Gửi đi
            Transport.send(msg);
            System.out.println("✅ Đã gửi mail thành công cho: " + toAddress);

        } catch (MessagingException e) {
            System.out.println("❌ Lỗi gửi mail:");
            e.printStackTrace();
        }
    }
}