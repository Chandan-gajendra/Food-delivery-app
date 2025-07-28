<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="navbar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>Manager Dashboard</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
body {
	background: linear-gradient(to right, #000428, #004e92);
	/* water-paint style */
	color: white;
	font-family: 'Segoe UI', sans-serif;
}

.card-title {
	font-size: 1.25rem;
	font-weight: bold;
}
</style>
</head>
<body>

	<div class="container mt-4">
		<h2 class="text-center text-warning mb-4">Manager Dashboard</h2>

		<div class="row g-4">
			<div class="col-md-4">
				<div class="card bg-dark text-light h-100">
					<div class="card-body text-center">
						<h5 class="card-title">&#128202; View Reports</h5>
						<p class="card-text">Analyze sales and performance reports.</p>
						<a href="view-reports.jsp" class="btn btn-primary w-100">Go</a>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card bg-dark text-light h-100">
					<div class="card-body text-center">
						<h5 class="card-title">&#11088; View Ratings</h5>
						<p class="card-text">See customer feedback and ratings.</p>
						<a href="view-ratings.jsp" class="btn btn-primary w-100">Go</a>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card bg-dark text-light h-100">
					<div class="card-body text-center">
						<h5 class="card-title">&#128276; Notifications</h5>
						<p class="card-text">Check latest notifications and messages.</p>
						<a href="notifications.jsp" class="btn btn-primary w-100">Go</a>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card bg-dark text-light h-100">
					<div class="card-body text-center">
						<h5 class="card-title">&#128179; Orders</h5>
						<p class="card-text">Manage customer orders and delivery
							status.</p>
						<a href="orders.jsp" class="btn btn-primary w-100">Go</a>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card bg-dark text-light h-100">
					<div class="card-body text-center">
						<h5 class="card-title">&#10133; Add Food</h5>
						<p class="card-text">Add new dishes to your menu.</p>
						<a href="add-food.jsp" class="btn btn-primary w-100">Go</a>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card bg-dark text-light h-100">
					<div class="card-body text-center">
						<h5 class="card-title">&#127828; View Foods</h5>
						<p class="card-text">Edit or remove your current menu items.</p>
						<a href="view-foods.jsp" class="btn btn-primary w-100">Go</a>
					</div>
				</div>
			</div>
		</div>

	</div>
</body>
</html>
