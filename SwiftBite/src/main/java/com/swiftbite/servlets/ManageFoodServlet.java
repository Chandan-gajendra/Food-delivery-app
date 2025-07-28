package com.swiftbite.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet implementation class ManageFoodServlet
 */
public class ManageFoodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userId") == null
				|| !"manager".equals(session.getAttribute("role"))) {
			response.sendRedirect("manager-login.jsp");
			return;
		}

		int managerId = (Integer) session.getAttribute("userId");
		String action = request.getParameter("action");

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			Class.forName("org.postgresql.Driver");
			conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/swiftbite", "postgres",
					"1234");

			if ("add".equals(action)) {
				String name = request.getParameter("name");
				String priceStr = request.getParameter("price");
				String availableStr = request.getParameter("available");
				Part imagePart = request.getPart("image");

				if (name == null || priceStr == null || availableStr == null || imagePart == null
						|| imagePart.getSize() == 0) {
					response.sendRedirect("add-food.jsp?error=Missing+fields");
					return;
				}

				double price = Double.parseDouble(priceStr);
				boolean available = Boolean.parseBoolean(availableStr);

				ps = conn.prepareStatement("SELECT id FROM hotels WHERE manager_id = ?");
				ps.setInt(1, managerId);
				rs = ps.executeQuery();
				if (!rs.next()) {
					response.sendRedirect("add-food.jsp?error=No+hotel+found+for+manager");
					return;
				}
				int hotelId = rs.getInt("id");
				rs.close();
				ps.close();

				ps = conn.prepareStatement(
						"INSERT INTO foods (hotel_id, name, price, available, image) VALUES (?, ?, ?, ?, ?)");
				ps.setInt(1, hotelId);
				ps.setString(2, name);
				ps.setDouble(3, price);
				ps.setBoolean(4, available);
				InputStream imageStream = imagePart.getInputStream();
				ps.setBinaryStream(5, imageStream, imagePart.getInputStream().available());

				int rowsInserted = ps.executeUpdate();
				if (rowsInserted > 0) {
					response.sendRedirect("view-foods.jsp?success=Food+added");
				} else {
					response.sendRedirect("add-food.jsp?error=Failed+to+add+food");
				}
				return;

			} else if ("toggle".equals(action)) {
				int foodId = Integer.parseInt(request.getParameter("foodId"));
				ps = conn.prepareStatement("UPDATE foods SET available = NOT available WHERE id=?");
				ps.setInt(1, foodId);
				ps.executeUpdate();
				response.sendRedirect("view-foods.jsp?success=Toggled+availability");
				return;

			} else if ("delete".equals(action)) {
				int foodId = Integer.parseInt(request.getParameter("foodId"));
				ps = conn.prepareStatement("DELETE FROM foods WHERE id=?");
				ps.setInt(1, foodId);
				ps.executeUpdate();
				response.sendRedirect("view-foods.jsp?success=Food+deleted");
				return;
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("view-foods.jsp?error=Something+went+wrong");
		}
	}
}