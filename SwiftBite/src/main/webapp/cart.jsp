<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <title>Your Cart</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <style>
    body {
      background: linear-gradient(to right, #000428, #004e92); /* dark blue water-paint style */
      color: white;
      font-family: 'Segoe UI', sans-serif;
    }
  </style>
</head>
<body>

<div class="container mt-4">
  <h2 class="text-center text-warning mb-4">&#128722; Your Cart</h2>

  <div class="card bg-dark text-light p-3 shadow">
  <%
     List<Map<String, String>> cart = (List<Map<String, String>>) request.getAttribute("cart");
     double total = 0.0;
     if (cart != null && !cart.isEmpty()) {
  %>
    <table class="table table-dark table-bordered text-center">
      <thead>
        <tr>
          <th>&#127828; Food</th>
          <th>&#127978; Hotel</th>
          <th>&#128230; Quantity</th>
          <th>&#8377; Price</th>
          <th>&#128178; Subtotal</th>
        </tr>
      </thead>
      <tbody>
      <%
         for (Map<String, String> item : cart) {
             double subtotal = Double.parseDouble(item.get("price")) * Integer.parseInt(item.get("quantity"));
             total += subtotal;
      %>
        <tr>
          <td><%= item.get("foodName") %></td>
          <td><%= item.get("hotelName") %></td>
          <td><%= item.get("quantity") %></td>
          <td>Rs.<%= item.get("price") %></td>
          <td>Rs.<%= subtotal %></td>
        </tr>
      <% } %>
      </tbody>
    </table>

    <h4 class="text-end text-warning">Total: Rs.<%= total %></h4>
    <form method="post" action="PlaceOrderServlet" class="text-center">
      <button class="btn btn-success mt-3">&#128179; Place Order</button>
    </form>

  <% } else { %>
    <p class="text-center text-light">&#128712; Your cart is empty. Start adding some delicious food!</p>
  <% } %>
  </div>

</div>

</body>
</html>
