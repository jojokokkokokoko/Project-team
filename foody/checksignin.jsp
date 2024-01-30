<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    String Email = request.getParameter("email");
    String Password = request.getParameter("passwords");


    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    if(Password=="admin784512"|| Email=="" ){response.sendRedirect("admin_form_user.jsp");}

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the connection
  conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_fruit_store?characterEncoding=utf-8", "root", "");

        // Prepare the SQL query
        String sql = "SELECT * FROM login_sigup WHERE email = ? AND password = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, Email);
        pstmt.setString(2, Password);

        // Execute the query
        rs = pstmt.executeQuery();
        if(Password==null || Email==null ){
        	out.println("Password or Email null<br>");
        }
        else if(Password.length()<6){
        	out.println("Password must be at least 6 characters long.<br>");
        }
        
        // Check if user credentials are valid
       
        if (rs.next()) {
            // User is authenticated, perform further actions or redirect to a different page
        	 response.sendRedirect("index.html");
        } else {
            // Invalid credentials, display an error message or redirect to the login page
            out.println(" email ເເລະ password ຜິດ . <br>");
        }
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
    if ("admin@gmail.com".equals(Email) && "admin789456".equals(Password)) {
        response.sendRedirect("admin/admin_form_user.jsp");
    }
     
  %>



</body>
</html>