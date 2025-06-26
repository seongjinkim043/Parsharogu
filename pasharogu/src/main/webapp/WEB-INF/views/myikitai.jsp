<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">



<style>
.ikitai-card {
    width: 180px;   /* 카드 가로 크기 */
    padding: 10px;
    border-radius: 10px;
    background-color: #fff;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    cursor: pointer;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
    display: inline-block;
    text-align: center;
}

.ikitai-card img {
   width: 100%;         /* 가로는 카드 너비에 맞춤 */
    height: 160px;       /* 세로 높이 제한 */
    object-fit: cover;  
}

.ikitai-card:hover {
    transform: scale(1.03);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.heart i {
    font-size: 14px;
    vertical-align: middle;
    transition: color 0.2s ease, transform 0.2s ease;
}

.heart:hover i {
    color: #ff4d4d;          /* hover 시 색 바뀜 */
    transform: scale(1.2);    /* 약간 커짐 */
}

.heart {
    display: inline-block;
    cursor: pointer;
}

</style>


<section class="ikitai-wrapper">
    <h2>行きたい</h2>

    <button class="arrow left" onclick="scrollIkitaiLeft()">&#9664;</button>
    <div class="ikitai-list" id="ikitaiList">
        <c:forEach var="ikitai" items="${ikitaiList}">
            <div class="ikitai-card">
                <img src="${ikitai.imageUrl}" alt="${ikitai.regionName}" />
                <div class="info">
                    <div class="place-name">${ikitai.regionName}</div>
                    <div class="rating">${ikitai.averageRating} ★★★★★</div>
                    <div class="heart" onclick="toggleIkitai(this, '${ikitai.regionId}')">
                        <c:choose>
                            <c:when test="${ikitai.liked}">
                                <i class="fa-solid fa-heart" style="color: red; font-size: 16px; vertical-align: middle;"></i>
                            </c:when>
                            <c:otherwise>
                                <i class="fa-regular fa-heart" style="color: gray; font-size: 16px; vertical-align: middle;"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
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
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ regionId: regionId })
        })
        .then(response => response.text())
        .then(result => {
            const icon = el.querySelector('i');

            if (result === 'added') {
                icon.classList.remove('fa-regular');
                icon.classList.add('fa-solid');
                icon.style.color = 'red';
            } else if (result === 'removed') {
                // ⭐ 하트 먼저 변화
                icon.classList.remove('fa-solid');
                icon.classList.add('fa-regular');
                icon.style.color = 'gray';
                icon.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
                icon.style.opacity = '0';
                icon.style.transform = 'scale(0.5)';

                // ⭐ 느리게 삭제 — 카드 페이드아웃 1.5초
                setTimeout(() => {
                    const card = el.closest('.ikitai-card');
                    card.style.transition = 'opacity 1.5s ease, transform 1.5s ease';
                    card.style.opacity = '0';
                    card.style.transform = 'scale(0.1)';
                    setTimeout(() => {
                        card.remove();
                    }, 1500);  // transition 과 일치
                }, 500);  // 하트 변화 후 0.5초 delay
            }
        });
    }


</script>
