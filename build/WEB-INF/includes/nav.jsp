<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="sidebar">
    <ul class="nav-menu">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
                <span class="nav-icon">📊</span>
                <span class="nav-text">Tableau de bord</span>
            </a>
        </li>
        
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/bassins" class="nav-link">
                <span class="nav-icon">🏊</span>
                <span class="nav-text">Bassins</span>
            </a>
        </li>
        
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/lots" class="nav-link">
                <span class="nav-icon">🐟</span>
                <span class="nav-text">Lots de poissons</span>
            </a>
        </li>
        
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/suivi" class="nav-link">
                <span class="nav-icon">📝</span>
                <span class="nav-text">Suivi quotidien</span>
            </a>
        </li>
        
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/stocks" class="nav-link">
                <span class="nav-icon">🥫</span>
                <span class="nav-text">Stock nourriture</span>
            </a>
        </li>
        
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/operations" class="nav-link">
                <span class="nav-icon">⚙️</span>
                <span class="nav-text">Opérations</span>
            </a>
        </li>
        
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/alertes" class="nav-link">
                <span class="nav-icon">⚠️</span>
                <span class="nav-text">Alertes</span>
            </a>
        </li>
        
        <c:if test="${sessionScope.userRole == 'admin'}">
            <li class="nav-section">
                <span class="nav-section-title">Administration</span>
            </li>
            
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/users" class="nav-link">
                    <span class="nav-icon">👥</span>
                    <span class="nav-text">Utilisateurs</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/especes" class="nav-link">
                    <span class="nav-icon">🐠</span>
                    <span class="nav-text">Espèces</span>
                </a>
            </li>
        </c:if>
    </ul>
</nav>