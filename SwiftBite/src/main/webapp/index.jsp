<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="navbar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>SwiftBite - Home</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
	background: linear-gradient(to right, #000428, #004e92);
	/* dark blue water-paint style */
	color: white;
	font-family: 'Segoe UI', sans-serif;
}

.btn-lg {
	font-size: 1.2rem;
}

.display-4 {
	color: #ffc107;
}

.container {
	margin-top: 100px;
}

.btn {
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
}
</style>
</head>
<body>
	<div class="container text-center">
		<h1 class="display-4">
			Welcome to <span class="text-warning">SwiftBite &#127828;</span>
		</h1>
		<p class="lead">Your favorite food delivered fast at your door!</p>

		<div class="mt-4">
			<a href="customer-login.jsp" class="btn btn-primary btn-lg mx-2">&#128100;
				Customer Login</a> <a href="customer-signup.jsp"
				class="btn btn-success btn-lg mx-2">&#128221; Customer Signup</a> <a
				href="manager-login.jsp" class="btn btn-secondary btn-lg mx-2">&#128188;
				Manager Login</a> <a href="manager-signup.jsp"
				class="btn btn-info btn-lg mx-2">&#128221; Manager Signup</a>
		</div>
	</div>
</body>
</html>
