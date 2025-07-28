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
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Servlet implementation class AddToCartServlet
 */
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@SuppressWarnings("unchecked")
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String foodId = request.getParameter("foodId");

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/swiftbite", "postgres", "1234");

            ps = conn.prepareStatement(
                "SELECT f.id, f.name AS food_name, f.price, h.name AS hotel_name " +
                "FROM foods f JOIN hotels h ON f.hotel_id = h.id WHERE f.id = ?");
            ps.setInt(1, Integer.parseInt(foodId));
            ResultSet rs = ps.executeQuery();

            if (!rs.next()) {
                response.sendRedirect("customer-dashboard.jsp?error=Food+not+found");
                return;
            }

            Map<String, String> item = new HashMap<>();
            item.put("id", rs.getString("id"));
            item.put("foodName", rs.getString("food_name"));
            item.put("price", rs.getString("price"));
            item.put("hotelName", rs.getString("hotel_name"));
            item.put("quantity", "1");

            HttpSession session = request.getSession();
            List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
            }

            boolean found = false;
            for (Map<String, String> c : cart) {
                if (c.get("id").equals(foodId)) {
                    int qty = Integer.parseInt(c.get("quantity")) + 1;
                    c.put("quantity", String.valueOf(qty));
                    found = true;
                    break;
                }
            }

            if (!found) {
                cart.add(item);
            }

            session.setAttribute("cart", cart);
            response.sendRedirect("customer-dashboard.jsp?success=Added+to+cart");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } finally {
            try { if (ps != null) ps.close(); if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}