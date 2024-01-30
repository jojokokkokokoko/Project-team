<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>
</head>
<body>

<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    // Get user ID from the request parameter
    int userId = 0; // default value or any suitable default
    String userIdParam = request.getParameter("id");

    if (userIdParam != null && !userIdParam.isEmpty()) {
        userId = Integer.parseInt(userIdParam);
    }

    // JDBC Connection
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_fruit_store?characterEncoding=utf-8", "root", "");

    // Fetch user details based on ID
    String selectSql = "SELECT * FROM login_sigup WHERE id_us = ?";
    pstmt = conn.prepareStatement(selectSql);
    pstmt.setInt(1, userId);
    rs = pstmt.executeQuery();

    if (rs.next()) {
        // Retrieve user details
        String phoneNumber = rs.getString("Phonenumber");
        String username = rs.getString("username");
        String email = rs.getString("email");
        String password = rs.getString("password");

        // Display the edit form
%>
        <h2>Edit User</h2>
        <form action="updateUser.jsp" method="post">
            <input type="hidden" name="id" value="<%= userId %>">
            Phone Number: <input type="text" name="phoneNumber" value="<%= phoneNumber %>"><br>
            Username: <input type="text" name="username" value="<%= username %>"><br>
            Email: <input type="text" name="email" value="<%= email %>"><br>
            Password: <input type="password" name="password" value="<%= password %>"><br>
            <input type="submit" value="Update">
        </form>
<%
    } else {
        out.println("User not found.");
    }

} catch (ClassNotFoundException | SQLException e) {
    e.printStackTrace();
    response.sendRedirect("error.jsp");
} finally {
    // Close resources in the reverse order of acquisition
    try {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    } catch (SQLException e) {
        out.println("Error closing resources: " + e.getMessage());
    }
}
%>

</body>
</html>
