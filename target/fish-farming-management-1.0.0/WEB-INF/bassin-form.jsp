<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty bassin ? 'Nouveau' : 'Modifier'} Bassin - Gestion Piscicole</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="includes/header.jsp" %>
    <%@ include file="includes/nav.jsp" %>

    <main class="main-content">
        <div class="container">
            <div class="page-header">
                <h1>${empty bassin ? 'Nouveau' : 'Modifier'} Bassin</h1>
                <a href="${pageContext.request.contextPath}/bassins" class="btn btn-secondary">
                    Retour à la liste
                </a>
            </div>

            <div class="card">
                <div class="card-content">
                    <form method="post">
                        <input type="hidden" name="action" value="save">
                        <c:if test="${not empty bassin}">
                            <input type="hidden" name="bassinId" value="${bassin.bassinId}">
                        </c:if>

                        <div class="form-grid">
                            <div class="form-group">
                                <label for="nom">Nom du bassin *</label>
                                <input type="text" id="nom" name="nom" value="${bassin.nom}" required>
                            </div>

                            <div class="form-group">
                                <label for="statut">Statut *</label>
                                <select id="statut" name="statut" required>
                                    <option value="">Sélectionner un statut</option>
                                    <option value="actif" ${bassin.statut == 'actif' ? 'selected' : ''}>Actif</option>
                                    <option value="maintenance" ${bassin.statut == 'maintenance' ? 'selected' : ''}>Maintenance</option>
                                    <option value="vide" ${bassin.statut == 'vide' ? 'selected' : ''}>Vide</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="capaciteM3">Capacité (m³) *</label>
                                <input type="number" id="capaciteM3" name="capaciteM3" step="0.01" 
                                       value="${bassin.capaciteM3}" required>
                            </div>

                            <div class="form-group">
                                <label for="typeBassinId">Type de bassin *</label>
                                <select id="typeBassinId" name="typeBassinId" required>
                                    <option value="">Sélectionner un type</option>
                                    <c:forEach var="type" items="${typesBassin}">
                                        <option value="${type.typeBassinId}" 
                                                ${bassin.typeBassinId == type.typeBassinId ? 'selected' : ''}>
                                            ${type.nom}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="localisation">Localisation</label>
                                <input type="text" id="localisation" name="localisation" value="${bassin.localisation}">
                            </div>

                            <div class="form-group">
                                <label for="dateMiseEnService">Date de mise en service</label>
                                <input type="date" id="dateMiseEnService" name="dateMiseEnService" 
                                       value="${bassin.dateMiseEnService}">
                            </div>

                            <div class="form-group full-width">
                                <label for="description">Description</label>
                                <textarea id="description" name="description" rows="3">${bassin.description}</textarea>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">
                                ${empty bassin ? 'Créer' : 'Modifier'} le bassin
                            </button>
                            <a href="${pageContext.request.contextPath}/bassins" class="btn btn-secondary">Annuler</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>
</body>
</html>