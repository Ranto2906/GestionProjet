package servlets;

import connect.Connexion;
import models.Bassin;

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
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/bassins")
public class BassinServlet extends HttpServlet {
    
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
            loadTypesBassin(request);
            request.getRequestDispatcher("/WEB-INF/bassin-form.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            loadBassin(request, id);
            loadTypesBassin(request);
            request.getRequestDispatcher("/WEB-INF/bassin-form.jsp").forward(request, response);
        } else {
            loadBassins(request);
            request.getRequestDispatcher("/WEB-INF/bassins.jsp").forward(request, response);
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
            saveBassin(request, response);
        } else if ("delete".equals(action)) {
            deleteBassin(request, response);
        }
    }

    private void loadBassins(HttpServletRequest request) {
        try (Connection conn = Connexion.openConnection()) {
            String sql = "SELECT b.*, tb.nom as type_nom FROM bassins b " +
                        "JOIN types_bassin tb ON b.type_bassin_id = tb.type_bassin_id " +
                        "ORDER BY b.nom";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            List<java.util.Map<String, Object>> bassins = new ArrayList<>();
            while (rs.next()) {
                java.util.Map<String, Object> bassin = new java.util.HashMap<>();
                bassin.put("bassinId", rs.getInt("bassin_id"));
                bassin.put("nom", rs.getString("nom"));
                bassin.put("statut", rs.getString("statut"));
                bassin.put("capaciteM3", rs.getBigDecimal("capacite_m3"));
                bassin.put("typeNom", rs.getString("type_nom"));
                bassin.put("localisation", rs.getString("localisation"));
                bassin.put("dateMiseEnService", rs.getDate("date_mise_en_service"));
                bassins.add(bassin);
            }
            request.setAttribute("bassins", bassins);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement des bassins");
        }
    }

    private void loadBassin(HttpServletRequest request, int id) {
        try (Connection conn = Connexion.openConnection()) {
            String sql = "SELECT * FROM bassins WHERE bassin_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Bassin bassin = new Bassin();
                bassin.setBassinId(rs.getInt("bassin_id"));
                bassin.setNom(rs.getString("nom"));
                bassin.setStatut(rs.getString("statut"));
                bassin.setCapaciteM3(rs.getBigDecimal("capacite_m3"));
                bassin.setTypeBassinId(rs.getInt("type_bassin_id"));
                bassin.setDescription(rs.getString("description"));
                bassin.setLocalisation(rs.getString("localisation"));
                if (rs.getDate("date_mise_en_service") != null) {
                    bassin.setDateMiseEnService(rs.getDate("date_mise_en_service").toLocalDate());
                }
                request.setAttribute("bassin", bassin);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement du bassin");
        }
    }

    private void loadTypesBassin(HttpServletRequest request) {
        try (Connection conn = Connexion.openConnection()) {
            String sql = "SELECT * FROM types_bassin ORDER BY nom";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            List<java.util.Map<String, Object>> types = new ArrayList<>();
            while (rs.next()) {
                java.util.Map<String, Object> type = new java.util.HashMap<>();
                type.put("typeBassinId", rs.getInt("type_bassin_id"));
                type.put("nom", rs.getString("nom"));
                types.add(type);
            }
            request.setAttribute("typesBassin", types);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void saveBassin(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try (Connection conn = Connexion.openConnection()) {
            String idParam = request.getParameter("bassinId");
            String nom = request.getParameter("nom");
            String statut = request.getParameter("statut");
            BigDecimal capacite = new BigDecimal(request.getParameter("capaciteM3"));
            int typeBassinId = Integer.parseInt(request.getParameter("typeBassinId"));
            String description = request.getParameter("description");
            String localisation = request.getParameter("localisation");
            String dateMiseEnServiceStr = request.getParameter("dateMiseEnService");
            
            if (idParam != null && !idParam.isEmpty()) {
                // Update existing bassin
                String sql = "UPDATE bassins SET nom = ?, statut = ?, capacite_m3 = ?, " +
                           "type_bassin_id = ?, description = ?, localisation = ?, " +
                           "date_mise_en_service = ?, date_mise_a_jour = NOW() WHERE bassin_id = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, nom);
                stmt.setString(2, statut);
                stmt.setBigDecimal(3, capacite);
                stmt.setInt(4, typeBassinId);
                stmt.setString(5, description);
                stmt.setString(6, localisation);
                if (dateMiseEnServiceStr != null && !dateMiseEnServiceStr.isEmpty()) {
                    stmt.setDate(7, java.sql.Date.valueOf(dateMiseEnServiceStr));
                } else {
                    stmt.setNull(7, java.sql.Types.DATE);
                }
                stmt.setInt(8, Integer.parseInt(idParam));
                stmt.executeUpdate();
            } else {
                // Insert new bassin
                String sql = "INSERT INTO bassins (nom, statut, capacite_m3, type_bassin_id, " +
                           "description, localisation, date_mise_en_service) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, nom);
                stmt.setString(2, statut);
                stmt.setBigDecimal(3, capacite);
                stmt.setInt(4, typeBassinId);
                stmt.setString(5, description);
                stmt.setString(6, localisation);
                if (dateMiseEnServiceStr != null && !dateMiseEnServiceStr.isEmpty()) {
                    stmt.setDate(7, java.sql.Date.valueOf(dateMiseEnServiceStr));
                } else {
                    stmt.setNull(7, java.sql.Types.DATE);
                }
                stmt.executeUpdate();
            }
            
            response.sendRedirect(request.getContextPath() + "/bassins");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/bassins?error=save");
        }
    }

    private void deleteBassin(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try (Connection conn = Connexion.openConnection()) {
            int id = Integer.parseInt(request.getParameter("id"));
            String sql = "DELETE FROM bassins WHERE bassin_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
            
            response.sendRedirect(request.getContextPath() + "/bassins");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/bassins?error=delete");
        }
    }
}