

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Users</title>
<!-- Bootstrap CSS -->

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
    <title>Bootstrap Example</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  
</head>
<body>
  <body class="p-3 m-0 border-0 bd-example m-0 border-0">

   
	<div class="container mt-5">
		<h2 class="text-center mb-4">Brand Record</h2>
		<div class="table-responsive">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>ID</th>
						<th>Brand Name</th>
					</tr>
				</thead>
				<tbody>
					<%
                    Connection conn = null;
                                            Statement stmt = null;
                                            ResultSet rs = null;
                                            
                                            try {
                                                Class.forName("com.mysql.jdbc.Driver");
                    					conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ultras", "root", "");
                    					stmt = conn.createStatement();
                    					String sql = "SELECT id,brand_name FROM brands";
                    					rs = stmt.executeQuery(sql);

                    					while (rs.next()) {
                    						int id = rs.getInt("id");
                    						String name = rs.getString("brand_name");
                    %>
					<tr>
						<td><%= id %></td>
						<td><%= name %></td>
					</tr>
					<% 
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                        }
                    %>
				</tbody>
			</table>
		</div>
	</div>

	<!-- Bootstrap JS (optional) -->
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>