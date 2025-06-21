package servlets;

import connect.Connexion;
import models.Utilisateur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = Connexion.openConnection()) {
            String sql = "SELECT user_id, nom, email, role FROM utilisateurs WHERE email = ? AND mot_de_passe = ? AND actif = TRUE";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password); // In production, use hashed passwords
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                // Login successful
                HttpSession session = request.getSession();
                session.setAttribute("userId", rs.getInt("user_id"));
                session.setAttribute("userName", rs.getString("nom"));
                session.setAttribute("userEmail", rs.getString("email"));
                session.setAttribute("userRole", rs.getString("role"));
                
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else {
                // Login failed
                request.setAttribute("error", "Email ou mot de passe incorrect");
                request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur de connexion à la base de données");
            request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
        }
    }
}