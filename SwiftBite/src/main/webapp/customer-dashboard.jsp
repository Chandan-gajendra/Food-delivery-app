<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ include file="navbar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>Customer Dashboard</title>
<style>
body {
	background: linear-gradient(to right, #000428, #004e92);
	color: white;
	font-family: 'Segoe UI', sans-serif;
}

.card-title {
	font-size: 1.25rem;
	font-weight: 600;
}

.card-text {
	font-size: 1rem;
}
</style>
</head>
<body>

	<div class="container mt-4">
		<h2 class="text-center text-warning mb-4">&#127828; Available
			Foods</h2>

		<div class="row">
			<% 
     List<Map<String, String>> foods = (List<Map<String, String>>) request.getAttribute("foods");
     if (foods != null) {
         for (Map<String, String> food : foods) {
  %>
			<div class="col-md-4 mb-4">
				<div class="card bg-dark text-light h-100">
					<img src="<%= food.get("imagePath") %>" class="card-img-top"
						alt="Food Image">
					<div class="card-body">
						<h5 class="card-title">
							&#127839;
							<%= food.get("name") %></h5>
						<p class="card-text">
							&#127970; Hotel:
							<%= food.get("hotelName") %></p>
						<form method="post" action="AddToCartServlet">
							<input type="hidden" name="foodId" value="<%= food.get("id") %>">
							<button class="btn btn-primary w-100">&#128722; Add to
								Cart</button>
						</form>
					</div>
				</div>
			</div>
			<% 
         }
     } else { 
  %>
			<p class="text-center text-light">No food items found.</p>
			<% } %>
		</div>

	</div>
</body>
</html>
