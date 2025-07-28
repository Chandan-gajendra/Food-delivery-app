<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Report Food Issue</title>
<script>
function validateReport() {
    const message = document.forms["reportForm"]["message"].value;
    if (message.trim() === "") {
        alert("Please enter your feedback or issue.");
        return false;
    }
    return true;
}
</script>
</head>
<body style="background: linear-gradient(to right, #000428, #004e92); color: white; font-family: 'Segoe UI', sans-serif;">

<div class="container mt-4">
  <h2 class="text-center text-warning mb-4">&#9888;&#65039; Report a Food Issue</h2>

  <div class="card bg-dark text-light p-4 col-md-6 offset-md-3">
    <form name="reportForm" method="post" action="ReportFoodServlet" onsubmit="return validateReport();">
      <div class="mb-3">
        <label for="food">&#127828; Select Food Item</label>
        <select name="foodId" class="form-control" required>
          <option value="">-- Select Food --</option>
          <% 
             // Assume list of foods passed by servlet
             List<Map<String, String>> foods = (List<Map<String, String>>) request.getAttribute("foods");
             if (foods != null) {
                 for (Map<String, String> food : foods) {
          %>
          <option value="<%= food.get("id") %>"><%= food.get("name") %> - <%= food.get("hotelName") %></option>
          <% 
                 }
             } 
          %>
        </select>
      </div>
      <div class="mb-3">
        <label>&#128172; Your Message</label>
        <textarea name="message" rows="4" class="form-control" required></textarea>
      </div>
      <div class="text-center">
        <button type="submit" class="btn btn-danger">&#9993; Submit Report</button>
      </div>
    </form>
  </div>
</div>

</body>
</html>
