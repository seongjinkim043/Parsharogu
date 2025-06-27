<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">


<section class="ikitai-wrapper">
   <h2 style="margin-bottom: 5px; padding-left: 10px;">行きたい</h2>

  <!-- 설명 문구 -->
  <p style="font-size: 13px; color: #999; margin-bottom: 20px; padding-left: 10px;">
    旅先候補をリストアップ！
  </p>
    <button class="arrow left" onclick="scrollIkitaiLeft()">&#9664;</button>
    <div class="ikitai-list" id="ikitaiList">
        <c:forEach var="ikitai" items="${ikitaiList}">
            <div class="ikitai-card">
                <!-- 이미지 (상단 지역명 제거됨) -->
                <c:choose>
                    <c:when test="${not empty ikitai.imageUrl}">
                        <img src="${ikitai.imageUrl}" alt="${ikitai.regionName}" />
                    </c:when>
                    <c:otherwise>
                        <img src="" alt="${ikitai.regionName}" />
                    </c:otherwise>
                </c:choose>

                <!-- 오른쪽 상단 하트 -->
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

                <!-- 하단 정보 -->
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
