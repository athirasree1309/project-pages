<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%

    String name = request.getParameter("name");
    String brandId = request.getParameter("brand_id");
    double price = Double.parseDouble(request.getParameter("price"));
     String color = request.getParameter("color");
    String specification = request.getParameter("specification");
    String image = request.getParameter("image");

  

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish the connection
        String url = "jdbc:mysql://localhost:3306/ultras"; // Adjust the URL, database name
        String user = "root"; // Your MySQL user
        String password = ""; // Your MySQL password
        conn = DriverManager.getConnection(url, user, password);

        // Prepare the SQL query
        String query = "INSERT INTO products (name, brand_id, price, color, specification, image) VALUES ( ?, ?, ?, ?, ?, ? )";
        ps = conn.prepareStatement(query);
        ps.setString(1, name);
        ps.setString(2,brandId);
        ps.setDouble(3,price);
/*         ps.setString(4, size);
 */        ps.setString(4, color);
        ps.setString(5, specification);
        ps.setString(6, image);

       // ps.setString(7, fileName);

        // Execute the query
        int result = ps.executeUpdate();

        if (result > 0) {
            // Save the image file to the server (example path)
            //java.nio.file.Path path = java.nio.file.Paths.get("/path/to/upload/directory/" + fileName);
           // java.nio.file.Files.copy(fileContent, path, java.nio.file.StandardCopyOption.REPLACE_EXISTING);

            out.println("<script>alert('Product added successfully!'); window.location.href='addproduct.jsp';</script>");
        } else {
            out.println("<script>alert('Failed to add product. Please try again.'); window.location.href='addproduct.jsp';</script>");
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<script>alert('An error occurred: " + e.getMessage() + "'); window.location.href='addproduct.jsp';</script>");
    } finally {
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
