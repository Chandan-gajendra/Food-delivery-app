<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="navbar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>View Reports</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
body {
	background: linear-gradient(to right, #000428, #004e92);
	color: white;
	font-family: 'Segoe UI', sans-serif;
}
</style>
</head>
<body>

	<div class="container mt-4">
		<h2 class="text-center text-warning mb-4">&#128462; View Sales &
			Performance Reports</h2>

		<div class="row g-4">
			<div class="col-md-6">
				<div class="card bg-dark text-light p-3">
					<h5 class="text-center">&#128200; Sales Over Time</h5>
					<canvas id="salesChart"></canvas>
				</div>
			</div>

			<div class="col-md-6">
				<div class="card bg-dark text-light p-3">
					<h5 class="text-center">&#127869; Top Selling Foods</h5>
					<canvas id="topFoodsChart"></canvas>
				</div>
			</div>
		</div>
	</div>

	<script>
		const salesCtx = document.getElementById('salesChart').getContext('2d');
		const topFoodsCtx = document.getElementById('topFoodsChart')
				.getContext('2d');

		const salesChart = new Chart(salesCtx, {
			type : 'line',
			data : {
				labels : [ 'Jan', 'Feb', 'Mar', 'Apr', 'May' ],
				datasets : [ {
					label : 'Sales',
					data : [ 1200, 1500, 800, 1700, 2000 ],
					borderColor : 'yellow',
					backgroundColor : 'rgba(255,255,0,0.2)',
					fill : true
				} ]
			}
		});

		const topFoodsChart = new Chart(topFoodsCtx, {
			type : 'bar',
			data : {
				labels : [ 'Pizza', 'Burger', 'Pasta', 'Salad', 'Sushi' ],
				datasets : [ {
					label : 'Orders',
					data : [ 50, 40, 30, 20, 10 ],
					backgroundColor : 'orange'
				} ]
			}
		});
	</script>

</body>
</html>
