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

/**
 * Servlet implementation class ManagerDashboardServlet
 */
public class ManagerDashboardServlet extends HttpServlet {
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
        PreparedStatement psFoods = null, psOrders = null, psRatings = null;

        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/swiftbite", "postgres", "1234");

            // Get food count
            psFoods = conn.prepareStatement("SELECT COUNT(*) FROM foods WHERE hotel_id IN (SELECT id FROM hotels WHERE manager_id=?)");
            psFoods.setInt(1, managerId);
            ResultSet rsFoods = psFoods.executeQuery();
            rsFoods.next();
            int foodCount = rsFoods.getInt(1);

            // Get order count
            psOrders = conn.prepareStatement(
                "SELECT COUNT(DISTINCT o.id) FROM orders o " +
                "JOIN order_items oi ON o.id=oi.order_id " +
                "JOIN foods f ON oi.food_id=f.id " +
                "JOIN hotels h ON f.hotel_id=h.id WHERE h.manager_id=?");
            psOrders.setInt(1, managerId);
            ResultSet rsOrders = psOrders.executeQuery();
            rsOrders.next();
            int orderCount = rsOrders.getInt(1);

            // Get ratings count
            psRatings = conn.prepareStatement(
                "SELECT COUNT(*) FROM ratings r " +
                "JOIN foods f ON r.food_id=f.id " +
                "JOIN hotels h ON f.hotel_id=h.id WHERE h.manager_id=?");
            psRatings.setInt(1, managerId);
            ResultSet rsRatings = psRatings.executeQuery();
            rsRatings.next();
            int ratingCount = rsRatings.getInt(1);

            request.setAttribute("foodCount", foodCount);
            request.setAttribute("orderCount", orderCount);
            request.setAttribute("ratingCount", ratingCount);

            RequestDispatcher rd = request.getRequestDispatcher("manager-dashboard.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } finally {
            try {
                if (psFoods != null) psFoods.close();
                if (psOrders != null) psOrders.close();
                if (psRatings != null) psRatings.close();
                if (conn != null) conn.close();
            } catch (Exception ignored) {}
        }
    }
}