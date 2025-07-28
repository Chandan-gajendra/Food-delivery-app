package com.swiftbite.servlets;

import jakarta.servlet.RequestDispatcher;
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
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Servlet implementation class ReportsServlet
 */
public class ReportsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null || !"manager".equals(session.getAttribute("role"))) {
            response.sendRedirect("manager-login.jsp");
            return;
        }

        int managerId = (Integer) session.getAttribute("userId");

        Connection conn = null;
        PreparedStatement psRevenue = null, psTopFoods = null;
        double totalRevenue = 0;
        List<Map<String, Object>> topFoods = new ArrayList<>();

        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/swiftbite", "postgres", "1234");

            // Total Revenue
            psRevenue = conn.prepareStatement(
                "SELECT COALESCE(SUM(oi.subtotal),0) AS revenue " +
                "FROM order_items oi " +
                "JOIN foods f ON oi.food_id=f.id " +
                "JOIN hotels h ON f.hotel_id=h.id " +
                "WHERE h.manager_id=?");
            psRevenue.setInt(1, managerId);
            ResultSet rsRevenue = psRevenue.executeQuery();
            if (rsRevenue.next()) {
                totalRevenue = rsRevenue.getDouble("revenue");
            }

            // Top Foods
            psTopFoods = conn.prepareStatement(
                "SELECT f.name, COUNT(oi.id) AS sold_qty, SUM(oi.subtotal) AS earnings " +
                "FROM order_items oi " +
                "JOIN foods f ON oi.food_id=f.id " +
                "JOIN hotels h ON f.hotel_id=h.id " +
                "WHERE h.manager_id=? " +
                "GROUP BY f.name ORDER BY sold_qty DESC LIMIT 5");
            psTopFoods.setInt(1, managerId);
            ResultSet rsTopFoods = psTopFoods.executeQuery();

            while (rsTopFoods.next()) {
                Map<String, Object> food = new HashMap<>();
                food.put("name", rsTopFoods.getString("name"));
                food.put("sold_qty", rsTopFoods.getInt("sold_qty"));
                food.put("earnings", rsTopFoods.getDouble("earnings"));
                topFoods.add(food);
            }

            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("topFoods", topFoods);
            RequestDispatcher rd = request.getRequestDispatcher("reports.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } finally {
            try {
                if (psRevenue != null) psRevenue.close();
                if (psTopFoods != null) psTopFoods.close();
                if (conn != null) conn.close();
            } catch (Exception ignored) {}
        }
    }
}