<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <title>View Foods</title>
</head>
<body>

<div class="container mt-4">
  <h2 class="text-center text-warning mb-4">&#127828; Manage Your Foods</h2> 

  <div class="card bg-dark text-light p-3">
  <%
     List<Map<String, String>> foods = (List<Map<String, String>>) request.getAttribute("foods");
     if (foods != null && !foods.isEmpty()) {
  %>
    <table class="table table-dark table-bordered">
      <thead>
        <tr>
          <th>&#128247; Image</th> 
          <th>&#127830; Name</th> 
          <th>&#8377; Price</th>
          <th>&#9989; Available</th> 
          <th>&#127969; Hotel</th> 
          <th>&#128295; Actions</th> 
        </tr>
      </thead>
      <tbody>
      <%
         for (Map<String, String> food : foods) {
      %>
        <tr>
          <td>
            <img src="FoodImageServlet?id=<%= food.get("id") %>" width="80" height="80" alt="Food">
          </td>
          <td><%= food.get("name") %></td>
          <td>Rs.<%= food.get("price") %></td>
          <td><%= "true".equals(food.get("available")) ? "Yes" : "No" %></td>
          <td><%= food.get("hotelName") %></td>
          <td>
            <form method="post" action="ManageFoodServlet" class="d-inline">
              <input type="hidden" name="foodId" value="<%= food.get("id") %>">
              <input type="hidden" name="action" value="toggle">
              <button class="btn btn-sm btn-warning">&#128472; Toggle</button> 
            </form>
            <form method="post" action="ManageFoodServlet" class="d-inline">
              <input type="hidden" name="foodId" value="<%= food.get("id") %>">
              <input type="hidden" name="action" value="delete">
              <button class="btn btn-sm btn-danger">&#128465; Delete</button> 
            </form>
          </td>
        </tr>
      <% } %>
      </tbody>
    </table>
  <% } else { %>
    <p class="text-center text-light">&#128577; No foods added yet. Use the Add Food option!</p> 
  <% } %>
  </div>

</div>

</body>
</html>
    