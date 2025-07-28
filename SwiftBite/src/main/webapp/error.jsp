<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error - SwiftBite</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to right, #000428, #004e92); /* dark blue water-paint style */
            color: white;
            font-family: 'Segoe UI', sans-serif;
        }
        .error-container {
            margin-top: 100px;
        }
        .emoji {
            font-size: 80px;
        }
    </style>
</head>
<body>

<div class="container text-center error-container">
    <div class="emoji">&#10060;</div> 
    <h2 class="mt-3">Oops! Something went wrong.</h2>
    <p class="lead">We're sorry, but an unexpected error occurred.</p>
    <a href="index.jsp" class="btn btn-outline-light mt-3">Go Back Home</a>
</div>

</body>
</html>