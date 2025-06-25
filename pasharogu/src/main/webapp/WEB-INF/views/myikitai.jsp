<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="ikitai-wrapper">
    <h2>行きたい</h2>

    <button class="arrow left" onclick="scrollIkitaiLeft()">&#9664;</button>
    <div class="ikitai-list" id="ikitaiList">
        <c:forEach var="ikitai" items="${ikitaiList}">
            <div class="ikitai-card animate-fade-in">
                <img src="${ikitai.imageUrl}" alt="${ikitai.regionName}" />
                <div class="info">
                    <div class="place-name">${ikitai.regionName}</div>
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

<!-- CSS -->
<style>
.ikitai-card {
    flex-shrink: 0;
    width: 180px; /* 살짝 키움 */
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.12);
    text-align: center;
    padding-bottom: 12px;
    position: relative;
    transition: transform 0.4s ease, opacity 0.4s ease;
    opacity: 1;
}

.ikitai-card img {
    width: 100%;
    height: 120px; /* 키움 */
    object-fit: cover;
    border-top-left-radius: 12px;
    border-top-right-radius: 12px;
}

.ikitai-card .info {
    padding: 10px;
}

.place-name {
    font-weight: bold;
    margin-bottom: 6px;
    font-size: 1.05em;
}

.rating {
    font-size: 0.9em;
    color: #f39c12;
    margin-bottom: 6px;
}

.heart {
    cursor: pointer;
    font-size: 22px;
    transition: transform 0.2s ease, color 0.2s ease;
}

.heart.on {
    color: red;
}

.heart.off {
    color: gray;
}

.heart:hover {
    transform: scale(1.3);
    color: #ff5555;
}

.arrow {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    z-index: 10;
    background-color: #D9D9D9;
    border: 1px solid #ccc;
    border-radius: 50%;
    width: 36px;
    height: 36px;
    cursor: pointer;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 0;
}

.arrow.left {
    left: 0px;
}

.arrow.right {
    right: 0px;
}

/* 카드 등장 애니메이션 */
.animate-fade-in {
    animation: fadeInUp 0.5s ease;
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}
</style>

<!-- JS -->
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
        console.log('Toggle result:', result);

        if (result === 'added') {
            el.textContent = '❤️';
        } else if (result === 'removed') {
            // fade out → remove
            const card = el.closest('.ikitai-card');
            card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
            card.style.opacity = '0';
            card.style.transform = 'scale(0.8)';
            setTimeout(() => {
                card.remove();
            }, 500);
        }
    });
}
</script>
