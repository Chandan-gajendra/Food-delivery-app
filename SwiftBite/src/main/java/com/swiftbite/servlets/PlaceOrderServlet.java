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
import java.util.List;
import java.util.Map;

/**
 * Servlet implementation class PlaceOrderServlet
 */
public class PlaceOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@SuppressWarnings("unchecked")
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("customer-login.jsp");
            return;
        }

        int customerId = (Integer) session.getAttribute("userId");
        List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp?error=Cart+is+empty");
            return;
        }

        Connection conn = null;
        PreparedStatement psOrder = null;
        PreparedStatement psItem = null;

        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/swiftbite", "postgres", "1234");

            conn.setAutoCommit(false);

            double total = 0;
            for (Map<String, String> item : cart) {
                total += Double.parseDouble(item.get("price")) * Integer.parseInt(item.get("quantity"));
            }

            psOrder = conn.prepareStatement(
                "INSERT INTO orders(customer_id, total) VALUES (?, ?) RETURNING id");
            psOrder.setInt(1, customerId);
            psOrder.setDouble(2, total);

            ResultSet rsOrder = psOrder.executeQuery();
            rsOrder.next();
            int orderId = rsOrder.getInt("id");

            psItem = conn.prepareStatement(
                "INSERT INTO order_items(order_id, food_id, quantity, subtotal) VALUES (?, ?, ?, ?)");

            for (Map<String, String> item : cart) {
                double price = Double.parseDouble(item.get("price"));
                int qty = Integer.parseInt(item.get("quantity"));
                psItem.setInt(1, orderId);
                psItem.setInt(2, Integer.parseInt(item.get("id")));
                psItem.setInt(3, qty);
                psItem.setDouble(4, price * qty);
                psItem.addBatch();
            }

            psItem.executeBatch();
            conn.commit();

            session.removeAttribute("cart");
            response.sendRedirect("cart.jsp?success=Order+placed+successfully");

        } catch (Exception e) {
            e.printStackTrace();
            try { if (conn != null) conn.rollback(); } catch (Exception ignored) {}
            response.sendRedirect("cart.jsp?error=Failed+to+place+order");
        } finally {
            try { if (psOrder != null) psOrder.close(); if (psItem != null) psItem.close(); if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}