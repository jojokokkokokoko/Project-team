<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete User</title>
</head>
<body>

<%
Connection conn = null;
PreparedStatement pstmt = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_fruit_store?characterEncoding=utf-8", "root", "");

    // Check if the 'id' parameter is present in the URL
    String userIdParam = request.getParameter("id");
    if (userIdParam != null && !userIdParam.isEmpty()) {
        int userId = Integer.parseInt(userIdParam);

        // Delete user based on the provided ID
        String deleteSql = "DELETE FROM login_sigup WHERE id_us=?";
        pstmt = conn.prepareStatement(deleteSql);
        pstmt.setInt(1, userId);
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            out.println("User with ID " + userId + " has been deleted successfully.");
            response.sendRedirect("admin_form_user.jsp");
        } else {
            out.println("No user found with ID " + userId);
        }
    } else {
        out.println("Invalid or missing 'id' parameter.");
    }
} catch (ClassNotFoundException | SQLException | NumberFormatException e) {
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
