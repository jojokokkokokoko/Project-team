<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Fruit</title>
    <!-- Add your CSS and JS links here if needed -->
</head>
<body>

<%


Connection connection = null;
connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/online_fruit_store", "root", "");
try {
	 Class.forName("com.mysql.cj.jdbc.Driver");
    // Check if the user is logged in as an admin (You need to implement your authentication mechanism)
    boolean isAdmin = true; // Replace with your authentication logic
    if (!isAdmin) {
        response.sendRedirect("login.jsp"); // Redirect to login page if not an admin
    }
String fruitIdPraram= request.getParameter("id");
    // Get the fruit ID from the request parameter
    if( fruitIdPraram !=null && !fruitIdPraram.isEmpty()){
    	int fruitId= Integer.parseInt(fruitIdPraram);

    // Retrieve fruit details from the database based on the fruit ID
  
        // JDBC Connection


        // Query to get fruit details
        String query = "SELECT * FROM fruits WHERE id=?";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setInt(1, fruitId);
        ResultSet resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            // Extract fruit details
            String name = resultSet.getString("name");
            String description = resultSet.getString("description");
            double price = resultSet.getDouble("price");
            int stock = resultSet.getInt("stock");
            String imageUrl = resultSet.getString("image_url");

            // Display the form for editing
%>
            <form action="updateFruit.jsp" method="POST">
                <input type="hidden" name="id" value="<%= fruitId %>">
                <label for="name">Name:</label>
                <input type="text" name="name" value="<%= name %>" required><br>

                <label for="description">Description:</label>
                <textarea name="description" required><%= description %></textarea><br>

                <label for="price">Price:</label>
                <input type="number" name="price" value="<%= price %>" step="0.01" required><br>

                <label for="stock">Stock:</label>
                <input type="number" name="stock" value="<%= stock %>" required><br>

                <label for="imageUrl">Image URL:</label>
                <input type="text" name="imageUrl" value="<%= imageUrl %>"><br>

                <input type="submit" value="Update">
            </form>
<% 
        } else {
            out.println("Fruit not found");
        }
    } else {
        out.println("Fruit ID parameter is missing or empty");
    }

} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("error.jsp");
} finally {
    // Close resources
    if (connection != null) {
        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
%>

</body>
</html>
