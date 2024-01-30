<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - Manage Fruits</title>
    <style>
        table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px;
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
    // ตรวจสอบสิทธิ์ของ Admin ที่เข้าถึงหน้านี้
    // โปรดแก้โค้ดตรวจสอบสิทธิ์ตามการล็อกอินของคุณ

    // ข้อมูลการเชื่อมต่อฐานข้อมูล
    String url = "jdbc:mysql://localhost:3306/online_fruit_store";
    String user = "root";
    String password = "";

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // เชื่อมต่อฐานข้อมูล
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // สร้างคำสั่ง SQL และดึงข้อมูล
        String sql = "SELECT * FROM fruits";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sql);

        // แสดงผลลัพธ์ในรูปแบบของตาราง
        out.println("<h2>Admin - Manage Fruits</h2>");
        out.println("<table>");
        out.println("<tr>");
        out.println("<th>ID</th>");
        out.println("<th>Name</th>");
        out.println("<th>Description</th>");
        out.println("<th>Price</th>");
        out.println("<th>Stock</th>");
        out.println("<th>Image</th>");
        out.println("<th>Created At</th>");
        out.println("<th>Updated At</th>");
        out.println("<th>Action</th>");
        out.println("</tr>");

        while (rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getInt("id") + "</td>");
            out.println("<td>" + rs.getString("name") + "</td>");
            out.println("<td>" + rs.getString("description") + "</td>");
            out.println("<td>" + rs.getDouble("price") + "</td>");
            out.println("<td>" + rs.getInt("stock") + "</td>");
            out.println("<td><img src='" + rs.getString("image_url") + "' width='50px' height='50px'></td>");
            out.println("<td>" + rs.getTimestamp("created_at") + "</td>");
            out.println("<td>" + rs.getTimestamp("updated_at") + "</td>");
            out.println("<td><a href='EditFruits.jsp?id=" + rs.getInt("id") + "'>Edit</a></td>");
            out.println("</tr>");
        }

        out.println("</table>");

    } catch (ClassNotFoundException | SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        // ปิดการใช้งานทรัพยากร
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("<p>Error closing resources: " + e.getMessage() + "</p>");
        }
    }
%>
</body>
</html>
