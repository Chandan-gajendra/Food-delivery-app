<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <title>Add New Food</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
  <style>
    body {
      background: linear-gradient(to right, #000428, #004e92); /* dark blue water-paint style */
      color: white;
      font-family: 'Segoe UI', sans-serif;
    }
    .card label {
      font-weight: 500;
    }
  </style>
  <script>
    function validateFood() {
      const name = document.forms["foodForm"]["name"].value;
      const price = document.forms["foodForm"]["price"].value;
      if (name.trim() === "" || price.trim() === "") {
        alert("Food name and price are required.");
        return false;
      }
      return true;
    }
  </script>
</head>
<body>

<div class="container mt-4">
  <h2 class="text-center text-warning mb-4">&#127829; Add New Food</h2>

  <div class="card bg-dark text-light p-4 col-md-6 offset-md-3">
    <form name="foodForm" method="post" action="ManageFoodServlet" enctype="multipart/form-data" onsubmit="return validateFood();">
      <div class="mb-3">
        <label>Food Name</label>
        <input type="text" class="form-control" name="name" required>
      </div>
      <div class="mb-3">
        <label>Price</label>
        <input type="number" step="0.01" class="form-control" name="price" required>
      </div>
      <div class="mb-3">
        <label>Available</label>
        <select name="available" class="form-control">
          <option value="true">Yes</option>
          <option value="false">No</option>
        </select>
      </div>
      <div class="mb-3">
        <label>Food Image</label>
        <input type="file" class="form-control" name="image" accept="image/*" required>
      </div>
      <div class="text-center">
        <button type="submit" class="btn btn-success">Add Food</button>
      </div>
    </form>
  </div>
</div>

</body>
</html>
