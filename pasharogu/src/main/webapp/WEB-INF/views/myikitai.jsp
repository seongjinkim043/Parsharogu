<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="ikitai-wrapper">
    <h2>行きたい</h2>

    <button class="arrow left" onclick="scrollIkitaiLeft()">&#9664;</button>
    <div class="ikitai-list" id="ikitaiList">
        <c:forEach var="ikitai" items="${ikitaiList}">
            <div class="ikitai-card">
                <a href="/ikitai/go?region=${ikitai.regionId}">
                    <img src="${ikitai.imageUrl}" alt="${ikitai.regionName}" />
                </a>
                <div class="info">
                    <div class="place-name">${ikitai.regionName}</div> <!-- ⭐ 이름 표시 -->
                    <div class="rating">${ikitai.averageRating} ★★★★★</div>
                    <div class="heart" onclick="toggleIkitai(this, '${ikitai.regionId}')">
                        <c:choose>
                            <c:when test="${ikitai.liked}">❤️</c:when>
                            <c:otherwise>🤍</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <button class="arrow right" onclick="scrollIkitaiRight()">&#9654;</button>
</section>
