<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update User</title>
</head>
<body>

<%
Connection conn = null;
PreparedStatement pstmt = null;

try {
    // Get user ID from the request parameter
    int userId = 0; // default value or any suitable default
    String userIdParam = request.getParameter("id");

    if (userIdParam != null && !userIdParam.isEmpty()) {
        userId = Integer.parseInt(userIdParam);
    }

    // Get form parameters
    String newPhoneNumber = request.getParameter("phoneNumber");
    String newUsername = request.getParameter("username");
    String newEmail = request.getParameter("email");
    String newPassword = request.getParameter("password");

    // JDBC Connection
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_fruit_store?characterEncoding=utf-8", "root", "");

    // Update user details in the database
    String updateSql = "UPDATE login_sigup SET Phonenumber=?, username=?, email=?, password=? WHERE id_us=?";
    pstmt = conn.prepareStatement(updateSql);
    pstmt.setString(1, newPhoneNumber);
    pstmt.setString(2, newUsername);
    pstmt.setString(3, newEmail);
    pstmt.setString(4, newPassword);
    pstmt.setInt(5, userId);

    int rowsUpdated = pstmt.executeUpdate();

    // Check if the update was successful
    if (rowsUpdated > 0) {


        response.sendRedirect("admin_form_user.jsp");
    } else {
%>
        <h2>Failed to Update User</h2>
        <p><a href="admin_form_user.jsp">Go back to User Management</a></p>
<%
    }

} catch (ClassNotFoundException | SQLException e) {
    e.printStackTrace();
    response.sendRedirect("error.jsp");
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
