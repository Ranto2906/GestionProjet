<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouveau Suivi Quotidien - Gestion Piscicole</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="includes/header.jsp" %>
    <%@ include file="includes/nav.jsp" %>

    <main class="main-content">
        <div class="container">
            <div class="page-header">
                <h1>Nouveau Suivi Quotidien</h1>
                <a href="${pageContext.request.contextPath}/suivi" class="btn btn-secondary">
                    Retour à la liste
                </a>
            </div>

            <div class="card">
                <div class="card-content">
                    <form method="post">
                        <input type="hidden" name="action" value="save">

                        <div class="form-grid">
                            <div class="form-group">
                                <label for="bassinId">Bassin *</label>
                                <select id="bassinId" name="bassinId" required>
                                    <option value="">Sélectionner un bassin</option>
                                    <c:forEach var="bassin" items="${bassins}">
                                        <option value="${bassin.bassinId}">${bassin.nom}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="lotsId">Lot de poissons *</label>
                                <select id="lotsId" name="lotsId" required>
                                    <option value="">Sélectionner un lot</option>
                                    <c:forEach var="lot" items="${lots}">
                                        <option value="${lot.lotsId}">${lot.nomCommun} (ID: ${lot.lotsId})</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="temperatureEau">Température de l'eau (°C)</label>
                                <input type="number" id="temperatureEau" name="temperatureEau" step="0.1" min="0" max="50">
                            </div>

                            <div class="form-group">
                                <label for="ph">pH</label>
                                <input type="number" id="ph" name="ph" step="0.1" min="0" max="14">
                            </div>

                            <div class="form-group">
                                <label for="oxygeneDissosMgL">Oxygène dissous (mg/L)</label>
                                <input type="number" id="oxygeneDissosMgL" name="oxygeneDissosMgL" step="0.1" min="0">
                            </div>

                            <div class="form-group">
                                <label for="mortaliteNombre">Nombre de mortalités</label>
                                <input type="number" id="mortaliteNombre" name="mortaliteNombre" min="0" value="0">
                            </div>

                            <div class="form-group">
                                <label for="poidsMoyenG">Poids moyen (g)</label>
                                <input type="number" id="poidsMoyenG" name="poidsMoyenG" step="0.1" min="0">
                            </div>

                            <div class="form-group">
                                <label for="quantiteAlimentG">Quantité d'aliment distribuée (g)</label>
                                <input type="number" id="quantiteAlimentG" name="quantiteAlimentG" step="0.1" min="0">
                            </div>

                            <div class="form-group">
                                <label for="typeAlimentId">Type d'aliment</label>
                                <select id="typeAlimentId" name="typeAlimentId">
                                    <option value="">Sélectionner un type</option>
                                    <c:forEach var="type" items="${typesAliment}">
                                        <option value="${type.typeAlimentId}">${type.nom}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group full-width">
                                <label for="observations">Observations</label>
                                <textarea id="observations" name="observations" rows="4" 
                                          placeholder="Notez vos observations sur le comportement des poissons, l'état de l'eau, etc."></textarea>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">Enregistrer le suivi</button>
                            <a href="${pageContext.request.contextPath}/suivi" class="btn btn-secondary">Annuler</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>
</body>
</html>