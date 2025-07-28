<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>View Ratings</title>
</head>
<body>

<div class="container mt-4">
  <h2 class="text-center text-warning mb-4">Customer Ratings & Feedback</h2>

  <div class="card bg-dark text-light p-3">
  <%
     // Servlet sets list of ratings
     List<Map<String, String>> ratings = (List<Map<String, String>>) request.getAttribute("ratings");
     if (ratings != null && !ratings.isEmpty()) {
  %>
    <table class="table table-dark table-bordered">
      <thead>
        <tr>
          <th>Food Item</th>
          <th>Customer</th>
          <th>Rating</th>
          <th>Comment</th>
        </tr>
      </thead>
      <tbody>
      <%
         for (Map<String, String> r : ratings) {
      %>
        <tr>
          <td><%= r.get("foodName") %></td>
          <td><%= r.get("customerName") %></td>
          <td>
            <% 
               int stars = Integer.parseInt(r.get("rating"));
               for (int i = 0; i < stars; i++) { %>*<% } 
            %>
          </td>
          <td><%= r.get("comment") %></td>
        </tr>
      <% } %>
      </tbody>
    </table>
  <% } else { %>
    <p class="text-center text-light">No ratings available yet.</p>
  <% } %>
  </div>

</div>

</body>
</html>
    