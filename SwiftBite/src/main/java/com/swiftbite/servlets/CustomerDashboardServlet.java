package com.swiftbite.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Servlet implementation class CustomerDashboardServlet
 */
public class CustomerDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/swiftbite", "postgres", "1234");

            ps = conn.prepareStatement(
                "SELECT f.id, f.name AS food_name, f.price, f.available, h.name AS hotel_name " +
                "FROM foods f JOIN hotels h ON f.hotel_id = h.id WHERE f.available = true");

            ResultSet rs = ps.executeQuery();

            List<Map<String, String>> foods = new ArrayList<>();
            while (rs.next()) {
                Map<String, String> food = new HashMap<>();
                food.put("id", rs.getString("id"));
                food.put("name", rs.getString("food_name"));
                food.put("price", rs.getString("price"));
                food.put("hotelName", rs.getString("hotel_name"));
                foods.add(food);
            }

            request.setAttribute("foods", foods);
            RequestDispatcher rd = request.getRequestDispatcher("customer-dashboard.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } finally {
            try { if (ps != null) ps.close(); if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}