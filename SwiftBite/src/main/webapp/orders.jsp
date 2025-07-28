<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <title>All Orders</title>
  <style>
    body {
      background: linear-gradient(to right, #000428, #004e92); /* dark blue water-paint */
      color: white;
      font-family: 'Segoe UI', sans-serif;
    }
  </style>
</head>
<body>

<div class="container mt-4">
  <h2 class="text-center text-warning mb-4">&#128462; All Orders</h2> 

  <div class="card bg-dark text-light p-3">
  <%
     List<Map<String, String>> orders = (List<Map<String, String>>) request.getAttribute("orders");
     if (orders != null && !orders.isEmpty()) {
  %>
    <table class="table table-dark table-bordered">
      <thead>
        <tr>
          <th>Order ID</th>
          <th>Customer</th>
          <th>Total</th>
          <th>Date</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
      <%
         for (Map<String, String> order : orders) {
      %>
        <tr>
          <td><%= order.get("id") %></td>
          <td><%= order.get("customerName") %></td>
          <td>Rs.<%= order.get("total") %></td>
          <td><%= order.get("createdAt") %></td>
          <td><%= order.get("status") %></td>
        </tr>
      <% } %>
      </tbody>
    </table>
  <% } else { %>
    <p class="text-center text-light">No orders have been placed yet.</p>
  <% } %>
  </div>

</div>

</body>
</html>
