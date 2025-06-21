<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="header">
    <div class="header-content">
        <div class="header-left">
            <a href="${pageContext.request.contextPath}/dashboard" class="logo">
                <span class="logo-icon">🐟</span>
                <span class="logo-text">Gestion Piscicole</span>
            </a>
        </div>
        
        <div class="header-right">
            <div class="user-info">
                <span class="user-name">Bienvenue, ${sessionScope.userName}</span>
                <span class="user-role badge badge-${sessionScope.userRole == 'admin' ? 'primary' : 'secondary'}">
                    ${sessionScope.userRole}
                </span>
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline">Déconnexion</a>
        </div>
    </div>
</header>