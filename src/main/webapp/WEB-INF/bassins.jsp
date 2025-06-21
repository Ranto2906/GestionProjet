<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Bassins - Gestion Piscicole</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="includes/header.jsp" %>
    <%@ include file="includes/nav.jsp" %>

    <main class="main-content">
        <div class="container">
            <div class="page-header">
                <h1>Gestion des Bassins</h1>
                <a href="${pageContext.request.contextPath}/bassins?action=new" class="btn btn-primary">
                    Nouveau Bassin
                </a>
            </div>

            <div class="card">
                <div class="card-content">
                    <c:choose>
                        <c:when test="${not empty bassins}">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Nom</th>
                                            <th>Statut</th>
                                            <th>Capacité (m³)</th>
                                            <th>Type</th>
                                            <th>Localisation</th>
                                            <th>Mise en service</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="bassin" items="${bassins}">
                                            <tr>
                                                <td><strong>${bassin.nom}</strong></td>
                                                <td>
                                                    <span class="badge badge-${bassin.statut == 'actif' ? 'success' : (bassin.statut == 'maintenance' ? 'warning' : 'secondary')}">
                                                        ${bassin.statut}
                                                    </span>
                                                </td>
                                                <td>${bassin.capaciteM3}</td>
                                                <td>${bassin.typeNom}</td>
                                                <td>${bassin.localisation}</td>
                                                <td>
                                                    <c:if test="${not empty bassin.dateMiseEnService}">
                                                        <fmt:formatDate value="${bassin.dateMiseEnService}" pattern="dd/MM/yyyy"/>
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <div class="action-buttons">
                                                        <a href="${pageContext.request.contextPath}/bassins?action=edit&id=${bassin.bassinId}" 
                                                           class="btn btn-sm btn-secondary">Modifier</a>
                                                        <form method="post" style="display: inline;" 
                                                              onsubmit="return confirm('Êtes-vous sûr de vouloir supprimer ce bassin ?')">
                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="id" value="${bassin.bassinId}">
                                                            <button type="submit" class="btn btn-sm btn-danger">Supprimer</button>
                                                        </form>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <h3>Aucun bassin enregistré</h3>
                                <p>Commencez par ajouter votre premier bassin</p>
                                <a href="${pageContext.request.contextPath}/bassins?action=new" class="btn btn-primary">
                                    Ajouter un bassin
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </main>
</body>
</html>