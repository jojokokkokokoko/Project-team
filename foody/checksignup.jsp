<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
<% String CountryCode = request.getParameter("CountryCode");
String Phonenumber = request.getParameter("phonenumber");
String Usname = request.getParameter("usname");
String Email = request.getParameter("email");
String Passwords = request.getParameter("passwords");
String confirm = request.getParameter("Confirm");
 // Add this line to get CountryCode

Connection conn = null;
PreparedStatement pstmt = null;

// Check if the password is at least 6 characters long
if (Passwords == null) {
    out.println("Password is required.");
} else if (Passwords.length() < 7) {
    out.println("Password must be at least 7 characters long.");
} else if (!Passwords.equals(confirm)) {
    out.println("Passwords do not match.");
} else {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_fruit_store?characterEncoding=utf-8", "root", "");

        // Use a prepared statement to prevent SQL injection
        String sql = "INSERT INTO login_sigup ( CountryCode,Phonenumber, username, email, password) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, CountryCode);
        pstmt.setString(2, Phonenumber);
        pstmt.setString(3, Usname);
        pstmt.setString(4, Email);
        pstmt.setString(5, Passwords);
        // Set the CountryCode parameter

        pstmt.executeUpdate();
       
        response.sendRedirect("Signin.jsp");

    } catch (ClassNotFoundException | SQLException e) {
        out.println("Error: " + e.getMessage());
    } finally {
        // Close resources in the reverse order of acquisition
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("Error closing resources: " + e.getMessage());
        }
    }
}
%>
</body>
</html>
