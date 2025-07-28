<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="navbar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>Profile</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
	background: linear-gradient(to right, #000428, #004e92);
	/* dark blue water-paint style */
	color: white;
	font-family: 'Segoe UI', sans-serif;
}
</style>
<script>
	function validateProfile() {
		const name = document.forms["profileForm"]["name"].value;
		const phone = document.forms["profileForm"]["phone"].value;
		if (name.trim() === "" || phone.trim() === "") {
			alert("Name and Phone cannot be empty.");
			return false;
		}
		return true;
	}
</script>
</head>
<body>

	<div class="container mt-4">
		<h2 class="text-center text-warning mb-4">&#128100; Your Profile</h2>

		<div class="card bg-dark text-light p-4 col-md-6 offset-md-3">
			<form name="profileForm" method="post" action="ProfileServlet"
				onsubmit="return validateProfile();">
				<div class="mb-3">
					<label>Name</label> <input type="text" class="form-control"
						name="name" value="<%=request.getAttribute("name")%>" required>
				</div>
				<div class="mb-3">
					<label>Birthdate</label> <input type="date" class="form-control"
						name="birthdate" value="<%=request.getAttribute("birthdate")%>">
				</div>
				<div class="mb-3">
					<label>Gender</label> <input type="text" class="form-control"
						name="gender" value="<%=request.getAttribute("gender")%>">
				</div>
				<div class="mb-3">
					<label>Phone</label> <input type="text" class="form-control"
						name="phone" value="<%=request.getAttribute("phone")%>" required>
				</div>
				<div class="mb-3">
					<label>Email</label> <input type="email" class="form-control"
						name="email" value="<%=request.getAttribute("email")%>" readonly>
				</div>
				<div class="text-center">
					<button type="submit" class="btn btn-success">Update
						Profile</button>
				</div>
			</form>
		</div>
	</div>

</body>
</html>
