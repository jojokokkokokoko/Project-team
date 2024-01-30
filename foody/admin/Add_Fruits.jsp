<!-- AddFruit.jsp -->

<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Fruit</title>
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
    PreparedStatement pstmt = null;

    try {
        // เชื่อมต่อฐานข้อมูล
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        if (request.getMethod().equalsIgnoreCase("post")) {
            // ถ้ามีการส่งข้อมูลแบบ POST

            // รับค่าจากฟอร์ม
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));
            String imageUrl = request.getParameter("image_url");

            // เพิ่มข้อมูลผลไม้ลงในฐานข้อมูล
            String sql = "INSERT INTO fruits (name, description, price, stock, image_url) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, description);
            pstmt.setDouble(3, price);
            pstmt.setInt(4, stock);
            pstmt.setString(5, imageUrl);
            pstmt.executeUpdate();

                // User is authenticated, perform further actions or redirect to a different page
            	 response.sendRedirect(" Admin_Manage_Fruits.jsp");
            
           
        }
%>

<h2>Add Fruit</h2>

<form action="Add_Fruits.jsp" method="post">
    Name: <input type="text" name="name" required><br>
    Description: <textarea name="description"></textarea><br>
    Price: <input type="text" name="price" required><br>
    Stock: <input type="text" name="stock" required><br>
    Image URL: <input type="text" name="image_url"><br>
    <input type="submit" value="Add Fruit">
</form>


<%
    } catch (ClassNotFoundException | SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        // ปิดการใช้งานทรัพยากร
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("<p>Error closing resources: " + e.getMessage() + "</p>");
        }
    }
%>

</body>
</html>
