package com.swiftbite.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 * Servlet implementation class RatingServlet
 */
public class RatingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	 public void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        HttpSession session = request.getSession(false);
	        if (session == null || session.getAttribute("userId") == null || !"customer".equals(session.getAttribute("role"))) {
	            response.sendRedirect("customer-login.jsp");
	            return;
	        }

	        int customerId = (Integer) session.getAttribute("userId");
	        int foodId = Integer.parseInt(request.getParameter("foodId"));
	        int rating = Integer.parseInt(request.getParameter("rating"));
	        String comment = request.getParameter("comment");

	        Connection conn = null;
	        PreparedStatement ps = null;

	        try {
	            Class.forName("org.postgresql.Driver");
	            conn = DriverManager.getConnection(
	                "jdbc:postgresql://localhost:5432/swiftbite", "postgres", "your_password");

	            ps = conn.prepareStatement(
	                "INSERT INTO ratings(food_id, customer_id, rating, comment) VALUES (?, ?, ?, ?)");
	            ps.setInt(1, foodId);
	            ps.setInt(2, customerId);
	            ps.setInt(3, rating);
	            ps.setString(4, comment);

	            ps.executeUpdate();

	            response.sendRedirect("ratings.jsp?success=Thanks+for+your+feedback!");

	        } catch (Exception e) {
	            e.printStackTrace();
	            response.sendRedirect("ratings.jsp?error=Failed+to+submit+rating");
	        } finally {
	            try { if (ps != null) ps.close(); if (conn != null) conn.close(); } catch (Exception ignored) {}
	        }
	    }
	}