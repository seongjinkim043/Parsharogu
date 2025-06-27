<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
.ikitai-wrapper {
    padding: 20px;
}

.ikitai-list {
    display: flex;
    overflow-x: auto;
    gap: 20px;
    padding: 10px 0;
    padding-left: 40px;  
}

.ikitai-card {
    position: relative;
    width: 180px;
    height: 250px;
    border-radius: 10px;
    background-color: #fff;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    cursor: pointer;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    overflow: hidden;
    flex-shrink: 0;
}

.ikitai-card:hover {
    transform: scale(1.03);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.ikitai-card img {
    width: 100%;
    height: 200px;
    object-fit: cover;
    background-color: #d9d9d9;
    font-size: 0;
}

.ikitai-card .info {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    height: 40px;
    padding: 5px;
}

.place-name {
    font-size: 17px;
    font-weight: bold;
    color: #333;
    margin-left: 5px;
    line-height: 1.1;
}

.rating {
    font-size: 14px;
    color: #666;
    margin-right: 4px;
    padding-bottom: 1px;
}

.heart {
    position: absolute;
    top: 8px;
    right: 10px;
    cursor: pointer;
    z-index: 10;
}

.heart i {
    font-size: 20px;
    transition: color 0.2s ease, transform 0.2s ease;
}

.heart:hover i {
    color: #ff4d4d;
    transform: scale(1.2);
}

.arrow {
    background: none;
    border: none;
    font-size: 24px;
    cursor: pointer;
    padding: 10px;
}
</style>

<section class="ikitai-wrapper">
    <h2 style="margin-bottom: 5px; padding-left: 10px;">行きたい</h2>
    <p style="font-size: 13px; color: #999; margin-bottom: 20px; padding-left: 10px;">
        旅先候補をリストアップ！
    </p>

    <button class="arrow left" onclick="scrollIkitaiLeft()">&#9664;</button>
    <div class="ikitai-list" id="ikitaiList">
        <c:forEach var="ikitai" items="${ikitaiList}">
            <div class="ikitai-card">
                <!-- 이미지 -->
                <c:choose>
                    <c:when test="${not empty ikitai.imageUrl}">
                        <img src="${ikitai.imageUrl}" alt="${ikitai.regionName}" />
                    </c:when>
                    <c:otherwise>
                        <img src="/images/default.jpg" alt="No image" />
                    </c:otherwise>
                </c:choose>

                <!-- 하트 -->
                <div class="heart" onclick="toggleIkitai(this, '${ikitai.regionId}')">
                    <c:choose>
                        <c:when test="${ikitai.liked}">
                            <i class="fa-solid fa-heart" style="color: red;"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="fa-regular fa-heart" style="color: gray;"></i>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- 이름 + 평점 -->
                <div class="info">
                    <div class="place-name">${ikitai.regionName}</div>
                    <div class="rating">★${ikitai.averageRating}</div>
                </div>
            </div>
        </c:forEach>
    </div>
    <button class="arrow right" onclick="scrollIkitaiRight()">&#9654;</button>
</section>

<script>
function scrollIkitaiLeft() {
    const container = document.getElementById('ikitaiList');
    container.scrollBy({ left: -220, behavior: 'smooth' });
}

function scrollIkitaiRight() {
    const container = document.getElementById('ikitaiList');
    container.scrollBy({ left: 220, behavior: 'smooth' });
}

function toggleIkitai(el, regionId) {
    fetch('/ikitai/toggle', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ regionId })
    })
    .then(response => response.text())
    .then(result => {
        const icon = el.querySelector('i');
        if (result === 'added') {
            icon.classList.remove('fa-regular');
            icon.classList.add('fa-solid');
            icon.style.color = 'red';
        } else if (result === 'removed') {
            icon.classList.remove('fa-solid');
            icon.classList.add('fa-regular');
            icon.style.color = 'gray';
            icon.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
            icon.style.opacity = '0';
            icon.style.transform = 'scale(0.5)';
            setTimeout(() => {
                const card = el.closest('.ikitai-card');
                card.style.transition = 'opacity 1.5s ease, transform 1.5s ease';
                card.style.opacity = '0';
                card.style.transform = 'scale(0.1)';
                setTimeout(() => {
                    card.remove();
                }, 1500);
            }, 500);
        }
    });
}
</script>
