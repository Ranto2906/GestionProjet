package servlets;

import connect.Connexion;
import models.SuiviQuotidien;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/suivi")
public class SuiviServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        
        if ("new".equals(action)) {
            loadBassinsAndLots(request);
            request.getRequestDispatcher("/WEB-INF/suivi-form.jsp").forward(request, response);
        } else {
            loadSuiviQuotidien(request);
            request.getRequestDispatcher("/WEB-INF/suivi.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        
        if ("save".equals(action)) {
            saveSuivi(request, response);
        }
    }

    private void loadSuiviQuotidien(HttpServletRequest request) {
        try (Connection conn = Connexion.openConnection()) {
            String sql = "SELECT sq.*, b.nom as bassin_nom, ep.nom_commun as espece_nom, u.nom as user_nom " +
                        "FROM suivi_quotidien sq " +
                        "JOIN bassins b ON sq.bassin_id = b.bassin_id " +
                        "JOIN lots_poissons lp ON sq.lots_id = lp.lots_id " +
                        "JOIN especes_poissons ep ON lp.espece_id = ep.espece_id " +
                        "JOIN utilisateurs u ON sq.user_id = u.user_id " +
                        "ORDER BY sq.date_observation DESC LIMIT 50";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            List<java.util.Map<String, Object>> suivis = new ArrayList<>();
            while (rs.next()) {
                java.util.Map<String, Object> suivi = new java.util.HashMap<>();
                suivi.put("suiviId", rs.getInt("suivi_id"));
                suivi.put("dateObservation", rs.getTimestamp("date_observation"));
                suivi.put("bassinNom", rs.getString("bassin_nom"));
                suivi.put("especeNom", rs.getString("espece_nom"));
                suivi.put("userNom", rs.getString("user_nom"));
                suivi.put("temperatureEau", rs.getBigDecimal("temperature_eau"));
                suivi.put("ph", rs.getBigDecimal("ph"));
                suivi.put("oxygeneDissosMgL", rs.getBigDecimal("oxygene_dissous_mgL"));
                suivi.put("mortaliteNombre", rs.getInt("mortalite_nombre"));
                suivi.put("poidsMoyenG", rs.getBigDecimal("poids_moyen_g"));
                suivi.put("quantiteAlimentG", rs.getBigDecimal("quantite_aliment_g"));
                suivi.put("observations", rs.getString("observations"));
                suivis.add(suivi);
            }
            request.setAttribute("suivis", suivis);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement des suivis");
        }
    }

    private void loadBassinsAndLots(HttpServletRequest request) {
        try (Connection conn = Connexion.openConnection()) {
            // Load active basins
            String sql = "SELECT bassin_id, nom FROM bassins WHERE statut = 'actif' ORDER BY nom";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            List<java.util.Map<String, Object>> bassins = new ArrayList<>();
            while (rs.next()) {
                java.util.Map<String, Object> bassin = new java.util.HashMap<>();
                bassin.put("bassinId", rs.getInt("bassin_id"));
                bassin.put("nom", rs.getString("nom"));
                bassins.add(bassin);
            }
            request.setAttribute("bassins", bassins);

            // Load active fish lots with species info
            sql = "SELECT lp.lots_id, lp.lots_id as id, ep.nom_commun " +
                  "FROM lots_poissons lp " +
                  "JOIN especes_poissons ep ON lp.espece_id = ep.espece_id " +
                  "WHERE lp.statut = 'actif' ORDER BY ep.nom_commun";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            List<java.util.Map<String, Object>> lots = new ArrayList<>();
            while (rs.next()) {
                java.util.Map<String, Object> lot = new java.util.HashMap<>();
                lot.put("lotsId", rs.getInt("lots_id"));
                lot.put("nomCommun", rs.getString("nom_commun"));
                lots.add(lot);
            }
            request.setAttribute("lots", lots);

            // Load feed types
            sql = "SELECT typeAliment_id, nom FROM types_aliment ORDER BY nom";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            List<java.util.Map<String, Object>> typesAliment = new ArrayList<>();
            while (rs.next()) {
                java.util.Map<String, Object> type = new java.util.HashMap<>();
                type.put("typeAlimentId", rs.getInt("typeAliment_id"));
                type.put("nom", rs.getString("nom"));
                typesAliment.add(type);
            }
            request.setAttribute("typesAliment", typesAliment);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement des données");
        }
    }

    private void saveSuivi(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try (Connection conn = Connexion.openConnection()) {
            HttpSession session = request.getSession();
            int userId = (Integer) session.getAttribute("userId");
            
            int bassinId = Integer.parseInt(request.getParameter("bassinId"));
            int lotsId = Integer.parseInt(request.getParameter("lotsId"));
            
            String tempStr = request.getParameter("temperatureEau");
            String phStr = request.getParameter("ph");
            String oxygeneStr = request.getParameter("oxygeneDissosMgL");
            String mortaliteStr = request.getParameter("mortaliteNombre");
            String poidsStr = request.getParameter("poidsMoyenG");
            String quantiteStr = request.getParameter("quantiteAlimentG");
            String typeAlimentStr = request.getParameter("typeAlimentId");
            String observations = request.getParameter("observations");
            
            String sql = "INSERT INTO suivi_quotidien (bassin_id, lots_id, user_id, " +
                        "temperature_eau, ph, oxygene_dissous_mgL, mortalite_nombre, " +
                        "poids_moyen_g, quantite_aliment_g, type_aliment_id, observations) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, bassinId);
            stmt.setInt(2, lotsId);
            stmt.setInt(3, userId);
            
            if (tempStr != null && !tempStr.isEmpty()) {
                stmt.setBigDecimal(4, new BigDecimal(tempStr));
            } else {
                stmt.setNull(4, java.sql.Types.DECIMAL);
            }
            
            if (phStr != null && !phStr.isEmpty()) {
                stmt.setBigDecimal(5, new BigDecimal(phStr));
            } else {
                stmt.setNull(5, java.sql.Types.DECIMAL);
            }
            
            if (oxygeneStr != null && !oxygeneStr.isEmpty()) {
                stmt.setBigDecimal(6, new BigDecimal(oxygeneStr));
            } else {
                stmt.setNull(6, java.sql.Types.DECIMAL);
            }
            
            if (mortaliteStr != null && !mortaliteStr.isEmpty()) {
                stmt.setInt(7, Integer.parseInt(mortaliteStr));
            } else {
                stmt.setInt(7, 0);
            }
            
            if (poidsStr != null && !poidsStr.isEmpty()) {
                stmt.setBigDecimal(8, new BigDecimal(poidsStr));
            } else {
                stmt.setNull(8, java.sql.Types.DECIMAL);
            }
            
            if (quantiteStr != null && !quantiteStr.isEmpty()) {
                stmt.setBigDecimal(9, new BigDecimal(quantiteStr));
            } else {
                stmt.setNull(9, java.sql.Types.DECIMAL);
            }
            
            if (typeAlimentStr != null && !typeAlimentStr.isEmpty()) {
                stmt.setInt(10, Integer.parseInt(typeAlimentStr));
            } else {
                stmt.setNull(10, java.sql.Types.INTEGER);
            }
            
            stmt.setString(11, observations);
            
            stmt.executeUpdate();
            
            response.sendRedirect(request.getContextPath() + "/suivi");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/suivi?error=save");
        }
    }
}