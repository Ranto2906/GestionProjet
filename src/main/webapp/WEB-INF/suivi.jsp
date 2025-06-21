<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Suivi Quotidien - Gestion Piscicole</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="includes/header.jsp" %>
    <%@ include file="includes/nav.jsp" %>

    <main class="main-content">
        <div class="container">
            <div class="page-header">
                <h1>Suivi Quotidien</h1>
                <a href="${pageContext.request.contextPath}/suivi?action=new" class="btn btn-primary">
                    Nouveau Suivi
                </a>
            </div>

            <div class="card">
                <div class="card-content">
                    <c:choose>
                        <c:when test="${not empty suivis}">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Bassin</th>
                                            <th>Espèce</th>
                                            <th>Observateur</th>
                                            <th>Température</th>
                                            <th>pH</th>
                                            <th>O₂ (mg/L)</th>
                                            <th>Mortalité</th>
                                            <th>Poids moyen</th>
                                            <th>Aliment</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="suivi" items="${suivis}">
                                            <tr>
                                                <td>
                                                    <fmt:formatDate value="${suivi.dateObservation}" pattern="dd/MM/yyyy HH:mm"/>
                                                </td>
                                                <td><strong>${suivi.bassinNom}</strong></td>
                                                <td>${suivi.especeNom}</td>
                                                <td>${suivi.userNom}</td>
                                                <td>
                                                    <c:if test="${not empty suivi.temperatureEau}">
                                                        <span class="metric-value">${suivi.temperatureEau}°C</span>
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${not empty suivi.ph}">
                                                        <span class="metric-value">${suivi.ph}</span>
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${not empty suivi.oxygeneDissosMgL}">
                                                        <span class="metric-value">${suivi.oxygeneDissosMgL}</span>
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${suivi.mortaliteNombre > 0}">
                                                            <span class="badge badge-warning">${suivi.mortaliteNombre}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge badge-success">0</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:if test="${not empty suivi.poidsMoyenG}">
                                                        <span class="metric-value">${suivi.poidsMoyenG}g</span>
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${not empty suivi.quantiteAlimentG}">
                                                        <span class="metric-value">${suivi.quantiteAlimentG}g</span>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <h3>Aucun suivi enregistré</h3>
                                <p>Commencez par ajouter votre premier suivi quotidien</p>
                                <a href="${pageContext.request.contextPath}/suivi?action=new" class="btn btn-primary">
                                    Ajouter un suivi
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