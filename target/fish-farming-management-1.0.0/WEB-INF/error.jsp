<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Erreur - Gestion Piscicole</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="error-container">
        <div class="error-content">
            <div class="error-icon">⚠️</div>
            <h1>Oops! Une erreur s'est produite</h1>
            <p class="error-message">
                <c:choose>
                    <c:when test="${not empty error}">
                        ${error}
                    </c:when>
                    <c:otherwise>
                        Une erreur inattendue s'est produite. Veuillez réessayer plus tard.
                    </c:otherwise>
                </c:choose>
            </p>
            <div class="error-actions">
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary">Retour au tableau de bord</a>
                <a href="javascript:history.back()" class="btn btn-secondary">Retour</a>
            </div>
        </div>
    </div>
</body>
</html>