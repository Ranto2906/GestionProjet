<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de bord - Gestion Piscicole</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="includes/header.jsp" %>
    <%@ include file="includes/nav.jsp" %>

    <main class="main-content">
        <div class="container">
            <div class="page-header">
                <h1>Tableau de bord</h1>
                <p>Vue d'ensemble de votre exploitation piscicole</p>
            </div>

            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon blue">🏊</div>
                    <div class="stat-content">
                        <h3>${activeBassins}</h3>
                        <p>Bassins actifs</p>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon green">🐟</div>
                    <div class="stat-content">
                        <h3>${activeLots}</h3>
                        <p>Lots de poissons</p>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon orange">⚠️</div>
                    <div class="stat-content">
                        <h3>${unresolvedAlerts}</h3>
                        <p>Alertes non résolues</p>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon purple">📊</div>
                    <div class="stat-content">
                        <h3>5</h3>
                        <p>Suivis aujourd'hui</p>
                    </div>
                </div>
            </div>

            <div class="dashboard-content">
                <div class="card">
                    <div class="card-header">
                        <h2>Suivi récent</h2>
                        <a href="${pageContext.request.contextPath}/suivi" class="btn btn-primary">Voir tout</a>
                    </div>
                    <div class="card-content">
                        <c:choose>
                            <c:when test="${not empty recentMonitoring}">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Date</th>
                                                <th>Bassin</th>
                                                <th>Espèce</th>
                                                <th>Température</th>
                                                <th>pH</th>
                                                <th>Mortalité</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="entry" items="${recentMonitoring}">
                                                <tr>
                                                    <td>
                                                        <fmt:formatDate value="${entry.dateObservation}" pattern="dd/MM/yyyy HH:mm"/>
                                                    </td>
                                                    <td>${entry.bassinNom}</td>
                                                    <td>${entry.especeNom}</td>
                                                    <td>
                                                        <c:if test="${not empty entry.temperatureEau}">
                                                            ${entry.temperatureEau}°C
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <c:if test="${not empty entry.ph}">
                                                            ${entry.ph}
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${entry.mortaliteNombre > 0}">
                                                                <span class="badge badge-warning">${entry.mortaliteNombre}</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge badge-success">0</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <p>Aucun suivi récent disponible</p>
                                    <a href="${pageContext.request.contextPath}/suivi?action=new" class="btn btn-primary">
                                        Ajouter un suivi
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </main>
</body>
</html>