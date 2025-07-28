<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="navbar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>Customer Login</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css">
<style>
body {
	background: linear-gradient(to right, #000428, #004e92);
	/* dark blue water-paint style */
	color: white;
	font-family: 'Segoe UI', sans-serif;
}

.card {
	background-color: rgba(0, 0, 0, 0.8);
	border-radius: 15px;
}

h2 {
	font-weight: bold;
}

.icon {
	font-size: 1.2rem;
	margin-right: 5px;
}
</style>
<script>
    function validateLogin() {
        const email = document.forms["loginForm"]["email"].value;
        const password = document.forms["loginForm"]["password"].value;
        if (email.trim() === "" || password.trim() === "") {
            alert("Email and Password cannot be empty.");
            return false;
        }
        return true;
    }
  </script>
</head>
<body>
	<div class="container mt-5">
		<div class="card text-light p-4 col-md-6 offset-md-3">
			<h2 class="text-center text-warning mb-4">&#128100; Customer
				Login</h2>
			<form name="loginForm" method="post" action="LoginServlet"
				onsubmit="return validateLogin();">
				<input type="hidden" name="role" value="customer">
				<div class="mb-3">
					<label for="email">&#128231; Email</label> <input type="email"
						class="form-control" name="email" required>
				</div>
				<div class="mb-3">
					<label for="password">&#128274; Password</label> <input
						type="password" class="form-control" name="password" required>
				</div>
				<div class="text-center">
					<button type="submit" class="btn btn-primary">&#128274;
						Login</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
