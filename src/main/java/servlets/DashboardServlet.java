package servlets;

import connect.Connexion;

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

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try (Connection conn = Connexion.openConnection()) {
            // Get dashboard statistics
            getDashboardStats(request, conn);
            request.getRequestDispatcher("/WEB-INF/dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement du tableau de bord");
            request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
        }
    }

    private void getDashboardStats(HttpServletRequest request, Connection conn) throws Exception {
        // Count active basins
        String sql = "SELECT COUNT(*) as count FROM bassins WHERE statut = 'actif'";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            request.setAttribute("activeBassins", rs.getInt("count"));
        }

        // Count active fish batches
        sql = "SELECT COUNT(*) as count FROM lots_poissons WHERE statut = 'actif'";
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();
        if (rs.next()) {
            request.setAttribute("activeLots", rs.getInt("count"));
        }

        // Count unresolved alerts
        sql = "SELECT COUNT(*) as count FROM alertes WHERE resolue = FALSE";
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();
        if (rs.next()) {
            request.setAttribute("unresolvedAlerts", rs.getInt("count"));
        }

        // Get recent monitoring entries
        sql = "SELECT sq.*, b.nom as bassin_nom, ep.nom_commun as espece_nom " +
              "FROM suivi_quotidien sq " +
              "JOIN bassins b ON sq.bassin_id = b.bassin_id " +
              "JOIN lots_poissons lp ON sq.lots_id = lp.lots_id " +
              "JOIN especes_poissons ep ON lp.espece_id = ep.espece_id " +
              "ORDER BY sq.date_observation DESC LIMIT 5";
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();
        
        java.util.List<java.util.Map<String, Object>> recentMonitoring = new java.util.ArrayList<>();
        while (rs.next()) {
            java.util.Map<String, Object> entry = new java.util.HashMap<>();
            entry.put("dateObservation", rs.getTimestamp("date_observation"));
            entry.put("bassinNom", rs.getString("bassin_nom"));
            entry.put("especeNom", rs.getString("espece_nom"));
            entry.put("temperatureEau", rs.getBigDecimal("temperature_eau"));
            entry.put("ph", rs.getBigDecimal("ph"));
            entry.put("mortaliteNombre", rs.getInt("mortalite_nombre"));
            recentMonitoring.add(entry);
        }
        request.setAttribute("recentMonitoring", recentMonitoring);
    }
}