<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="navbar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>Manager Login</title>
<style>
body {
	background: linear-gradient(to right, #000428, #004e92);
	/* dark blue water-paint style */
	color: white;
	font-family: 'Segoe UI', sans-serif;
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
		<div class="card bg-dark text-light p-4 col-md-6 offset-md-3">
			<h2 class="text-center text-warning">&#128273; Manager Login</h2>
			<form name="loginForm" method="post" action="LoginServlet"
				onsubmit="return validateLogin();">
				<input type="hidden" name="role" value="manager">
				<div class="mb-3">
					<label>&#128231; Email</label>
					<input type="email" class="form-control" name="email" required>
				</div>
				<div class="mb-3">
					<label>&#128274; Password</label>
					<input type="password" class="form-control" name="password"
						required>
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
