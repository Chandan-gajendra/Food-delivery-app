<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <title>Notifications</title>
  <style>
    body {
      background: linear-gradient(to right, #000428, #004e92);
      color: white;
      font-family: 'Segoe UI', sans-serif;
    }
  </style>
</head>
<body>

<div class="container mt-4">
  <h2 class="text-center text-warning mb-4">&#128276; Notifications</h2> 

  <div class="card bg-dark text-light p-3">
  <%
     List<Map<String, String>> notifications = (List<Map<String, String>>) request.getAttribute("notifications");
     if (notifications != null && !notifications.isEmpty()) {
  %>
    <ul class="list-group list-group-flush">
      <%
         for (Map<String, String> n : notifications) {
      %>
      <li class="list-group-item bg-dark text-light">
        <strong><%= n.get("type") %>:</strong> <%= n.get("message") %>
        <span class="float-end text-muted"><%= n.get("time") %></span>
      </li>
      <% } %>
    </ul>
  <% } else { %>
    <p class="text-center text-light">No new notifications at this time.</p>
  <% } %>
  </div>

</div>

</body>
</html>
