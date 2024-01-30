<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Database Connection Test</title>
</head>
<body>

<h1>Vannaxay sangpachan 2cw3</h1>
<h1>LOGIN: </h1>

<%
    String name= request.getParameter("name");
    String email = request.getParameter("email");
    String subject= request.getParameter("subject");
    String message = request.getParameter("message");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/foody_db?characterEncoding=utf-8", "root", "");

        // Use a prepared statement to prevent SQL injection
        String sql = "INSERT INTO contact_messages (name,email,subject,message) VALUES (?, ?,?,?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
          pstmt.setString(3, subject);
        pstmt.setString(4, message); 
        pstmt.executeUpdate();

        out.print("Connected to the database and data inserted successfully");

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
%>

</body>
</html>
