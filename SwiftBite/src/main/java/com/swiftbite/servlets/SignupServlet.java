package com.swiftbite.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.mindrot.jbcrypt.BCrypt;
/**
 * Servlet implementation class SignupServlet
 */
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String birthdate = request.getParameter("birthdate");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); // "customer" or "manager"

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/swiftbite", "postgres", "1234");

            // Check if email already exists
            ps = conn.prepareStatement("SELECT id FROM users WHERE email = ?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                request.setAttribute("error", "Email already registered!");
                request.getRequestDispatcher("customer-signup.jsp").forward(request, response);
                return;
            }

            // Insert new user
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            ps = conn.prepareStatement ( "INSERT INTO users(name, birthdate, gender, phone, email, password, role) VALUES (?, ?, ?, ?, ?, ?, ?)" );
            ps.setString(1, name);
            ps.setDate(2, Date.valueOf(birthdate));
            ps.setString(3, gender);
            ps.setString(4, phone);
            ps.setString(5, email);
            ps.setString(6, hashedPassword);
            ps.setString(7, role);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("customer-login.jsp");
            } else {
                request.setAttribute("error", "Signup failed. Please try again.");
                request.getRequestDispatcher("customer-signup.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("customer-signup.jsp").forward(request, response);
        } finally {
            try { if (ps != null) ps.close(); if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}