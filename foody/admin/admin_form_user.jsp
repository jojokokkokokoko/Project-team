<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
    <style>
        table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px auto;
        }

        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_fruit_store?characterEncoding=utf-8", "root", "");

    // Fetch all users from the database
    String selectSql = "SELECT * FROM login_sigup";
    pstmt = conn.prepareStatement(selectSql);
    rs = pstmt.executeQuery();
%>

<!-- Display User Data in HTML Table -->
<table>
    <tr>
        <th>ID</th>
        <th>Phone Number</th>
        <th>Username</th>
        <th>Email</th>
        <th>Password</th>
        <th>Action</th>
                <th>Action</th>
    </tr>
<%
    while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("id_us") %></td>
        <td><%= rs.getString("Phonenumber") %></td>
        <td><%= rs.getString("username") %></td>
        <td><%= rs.getString("email") %></td>
        <td><%= rs.getString("password") %></td>
        <td>
            <a href="editUser.jsp?id=<%= rs.getInt("id_us") %>">Edit</a>
            <td>
            <a href="deleteUser.jsp?id=<%= rs.getInt("id_us") %>">Delete</a>
        </td>
        </td>
    </tr>
<%
    }
%>
</table>

<%
} catch (ClassNotFoundException | SQLException e) {
    out.println("Error: " + e.getMessage());
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
