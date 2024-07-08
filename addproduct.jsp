<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
    import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Cloth</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        .size-badge {
            cursor: pointer;
            user-select: none;
            margin-right: 5px;
            margin-bottom: 5px;
            padding: 8px 12px;
            background-color: #007bff;
            color: #fff;
            border-radius: 20px;
            font-size: 14px;
        }

        .size-badge.selected {
            background-color: #6c757d;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <h2 class="text-center mb-4">Add Product</h2>
                <form action="addProductAction.jsp" method="post" >
                    <div class="form-group">
                        <label for="name">Name</label>
                        <input type="text" class="form-control" id="name" name="name">
                    </div>
                    <div class="form-group">
                        <label for="brand_id">Brand</label>
                        <select class="form-control" id="brand_id" name="brand_id" >
                            <option value="">Select Brand</option>
                            <% 
                                Connection conn = null;
                                PreparedStatement ps = null;
                                ResultSet rs = null;

                                try {
                                    // Load the JDBC driver
                                    Class.forName("com.mysql.jdbc.Driver");

                                    // Establish the connection
                                    String url = "jdbc:mysql://localhost:3306/ultras"; // Adjust the URL, database name
                                    String user = "root"; // Your MySQL user
                                    String password = ""; // Your MySQL password
                                    conn = DriverManager.getConnection(url, user, password);

                                    // Prepare the SQL query
                                    String query = "SELECT id, name FROM brands";
                                    ps = conn.prepareStatement(query);
                                    rs = ps.executeQuery();

                                    // Populate the options dynamically
                                    while (rs.next()) {
                                        int id = rs.getInt("id");
                                        String name = rs.getString("name");
                            %>
                            <option value="<%=id%>"><%=name%></option>
                            <% 
                                }
                                } catch (SQLException | ClassNotFoundException e) {
                                    e.printStackTrace();
                                } finally {
                                    if (rs != null) {
                                        try {
                                            rs.close();
                                        } catch (SQLException e) {
                                            e.printStackTrace();
                                        }
                                    }
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
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="price">Price</label>
                        <input type="number" class="form-control" id="price" name="price" step="0.01" >
                    </div>
                    <div class="form-group">
                        <label for="size">Size</label>
                        <div class="d-flex flex-wrap" id="sizeSelection">
                            <div class="form-check">
                                <span class="badge rounded-pill text-bg-primary size-badge" data-size="XS">XS</span>
                            </div>
                            <div class="form-check">
                                <span class="badge rounded-pill text-bg-primary size-badge" data-size="S">S</span>
                            </div>
                            <div class="form-check">
                                <span class="badge rounded-pill text-bg-primary size-badge" data-size="M">M</span>
                            </div>
                            <div class="form-check">
                                <span class="badge rounded-pill text-bg-primary size-badge" data-size="L">L</span>
                            </div>
                            <div class="form-check">
                                <span class="badge rounded-pill text-bg-primary size-badge" data-size="XL">XL</span>
                            </div>
                            <div class="form-check">
                                <span class="badge rounded-pill text-bg-primary size-badge" data-size="XXL">XXL</span>
                            </div>
                        </div>
                        <input type="hidden" id="selectedSizes" name="selectedSizes" value="">
                    </div>
                    <div class="form-group">
                        <label for="color">Color</label>
                        <input type="text" class="form-control" id="color" name="color" >
                    </div>
                    <div class="form-group">
                        <label for="specification">Specification</label>
                        <textarea class="form-control" id="specification" name="specification" rows="3" ></textarea>
                    </div>
                    <div class="form-group">
                        <label for="image">Image</label>
                        <input type="text" class="form-control" id="image" name="image" >
                    </div>
                    <button type="submit" class="btn btn-primary">Submit</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS (optional) -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- Custom JavaScript -->
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const sizeBadges = document.querySelectorAll(".size-badge");

            sizeBadges.forEach(badge => {
                badge.addEventListener("click", function() {
                    this.classList.toggle("selected");

                    // Update hidden input with selected sizes
                    updateSelectedSizes();
                });
            });

            function updateSelectedSizes() {
                const selectedSizes = Array.from(sizeBadges)
                    .filter(badge => badge.classList.contains("selected"))
                    .map(badge => badge.dataset.size);

                document.getElementById("selectedSizes").value = selectedSizes.join(",");
            }
        });
    </script>
</body>
</html>
