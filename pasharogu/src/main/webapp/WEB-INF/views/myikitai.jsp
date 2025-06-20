<%@ page contentType="text/html; charset=UTF-8" %>

<section class="ikitai-wrapper">
    <h2>行きたい</h2>
    <p>旅行先候補をリストアップ！</p>

    <button class="arrow left" onclick="scrollIkitaiLeft()">&#9664;</button>
    <div class="ikitai-list" id="ikitaiList">
        <c:forEach var="ikitai" items="${ikitaiList}">
            <div class="ikitai-card">
                <a href="/ikitai/go?region=${ikitai.regionName}">
                    <img src="${ikitai.imageUrl}" alt="${ikitai.regionName}" />
                </a>
                <div class="info">
                    <div class="region-name">${ikitai.regionName}</div>
                    <div class="rating">5.0 ★★★★★</div>
                    <div class="heart" onclick="toggleIkitai(this, '${ikitai.placeId}')">
                        ${ikitai.liked ? '❤️' : '🤍'}
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <button class="arrow right" onclick="scrollIkitaiRight()">&#9654;</button>
</section>
