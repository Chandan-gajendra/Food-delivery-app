<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="navbar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>Manager Signup</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
	background: linear-gradient(to right, #000428, #004e92);
	color: white;
	font-family: 'Segoe UI', sans-serif;
}

label::before {
	margin-right: 5px;
}
</style>
<script>
    function validateSignup() {
      const name = document.forms["signupForm"]["name"].value;
      const email = document.forms["signupForm"]["email"].value;
      const password = document.forms["signupForm"]["password"].value;
      if (name.trim() === "" || email.trim() === "" || password.trim() === "") {
          alert("Name, Email, and Password are required.");
          return false;
      }
      return true;
    }
  </script>
</head>
<body>
	<div class="container mt-5">
		<div
			class="card bg-dark text-light p-4 col-md-6 offset-md-3 shadow-lg rounded">
			<h2 class="text-center text-warning mb-4">&#128100; Manager
				Signup</h2>
			<form name="signupForm" method="post" action="SignupServlet"
				onsubmit="return validateSignup();">
				<input type="hidden" name="role" value="manager">

				<div class="mb-3">
					<label>&#128100; Name</label> <input type="text"
						class="form-control" name="name" required>
				</div>

				<div class="mb-3">
					<label>&#128197; Birthdate</label> <input type="date"
						class="form-control" name="birthdate">
				</div>

				<div class="mb-3">
					<label>&#9794;&#65039;/&#9792;&#65039; Gender</label> <input
						type="text" class="form-control" name="gender">
				</div>

				<div class="mb-3">
					<label>&#128222; Phone</label> <input type="text"
						class="form-control" name="phone">
				</div>

				<div class="mb-3">
					<label>&#128231; Email</label> <input type="email"
						class="form-control" name="email" required>
				</div>

				<div class="mb-3">
					<label>&#128274; Password</label> <input type="password"
						class="form-control" name="password" required>
				</div>

				<div class="text-center">
					<button type="submit" class="btn btn-info">&#9989; Signup</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
