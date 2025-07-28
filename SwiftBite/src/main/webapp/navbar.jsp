<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<%
    String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html>
<head>
<title>SwiftBite</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<style>
    body {
        background-image: url('images/water-paint-bg.jpg');
        background-size: cover;
        background-attachment: fixed;
        background-repeat: no-repeat;
        color: #fff;
    }
    .navbar-brand {
        font-family: 'Segoe UI', sans-serif;
        font-weight: 600;
        letter-spacing: 1px;
        margin-right: 40px;
    }
</style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
<div class="container-fluid">
  <a class="navbar-brand" href="<%= (role==null)?"index.jsp":(role.equals("customer")?"customer-dashboard.jsp":"manager-dashboard.jsp") %>">&#127828; SwiftBite</a>

  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarNav">
    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
    <% if (role == null) { %>
      <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
      <li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
      <li class="nav-item"><a class="nav-link" href="customer-login.jsp">Customer Login</a></li>
      <li class="nav-item"><a class="nav-link" href="customer-signup.jsp">Customer Signup</a></li>
      <li class="nav-item"><a class="nav-link" href="manager-login.jsp">Manager Login</a></li>
      <li class="nav-item"><a class="nav-link" href="manager-signup.jsp">Manager Signup</a></li>
    <% } else if ("customer".equals(role)) { %>
      <li class="nav-item"><a class="nav-link" href="customer-dashboard.jsp">Home</a></li>
      <li class="nav-item"><a class="nav-link" href="profile.jsp">Profile</a></li>
      <li class="nav-item"><a class="nav-link" href="cart.jsp">Cart</a></li>
      <li class="nav-item"><a class="nav-link" href="report-food.jsp">Report Food</a></li>
    <% } else if ("manager".equals(role)) { %>
      <li class="nav-item"><a class="nav-link" href="manager-dashboard.jsp">Home</a></li>
      <li class="nav-item"><a class="nav-link" href="view-reports.jsp">View Reports</a></li>
      <li class="nav-item"><a class="nav-link" href="view-ratings.jsp">View Ratings</a></li>
      <li class="nav-item"><a class="nav-link" href="notifications.jsp">Notifications</a></li>
      <li class="nav-item"><a class="nav-link" href="orders.jsp">Orders</a></li>
      <li class="nav-item"><a class="nav-link" href="add-food.jsp">Add Food</a></li>
      <li class="nav-item"><a class="nav-link" href="view-foods.jsp">View Foods</a></li>
      <li class="nav-item"><a class="nav-link" href="profile.jsp">Profile</a></li>
    <% } %>
    </ul>

    <% if ("customer".equals(role)) { %>
      <form class="d-flex" action="SearchServlet" method="get">
        <input class="form-control me-2" name="query" placeholder="Search food or hotel" required>
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
    <% } %>

    <% if (role != null) { %>
      <ul class="navbar-nav ms-3">
        <li class="nav-item">
          <a class="nav-link text-danger" href="LogoutServlet">Logout</a>
        </li>
      </ul>
    <% } %>
  </div>
</div>
</nav>
<hr>
