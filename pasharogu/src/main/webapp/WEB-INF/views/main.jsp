<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>일본 여행 다이어리</title>
    <link rel="stylesheet" href="/css/main.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/js/main.js"></script>
</head>
<body>

<div class="container">

    <!-- 🗾 지도 영역 -->
    <div class="map-area">
        <img src="/img/japan.svg" alt="일본 지도" class="japan-map-img"/>

        <!-- 예시: 위치 클릭 박스 -->
        <div class="region-btn" style="top:20%; left:60%;" onclick="loadRegion('도쿄')">도쿄</div>
        <div class="region-btn" style="top:40%; left:55%;" onclick="loadRegion('오사카')">오사카</div>
        <!-- 나머지 도도부현 추가 -->
    </div>

    <!-- 📍 우측 정보 영역 -->
    <div class="info-area">
        <!-- ⬆️ 지역 요약 정보 -->
        <div id="region-summary">
            <h2>지역을 선택해보세요</h2>
        </div>

        <!-- 📝 리뷰 목록 -->
        <div id="review-list">
            <p>리뷰가 여기에 표시됩니다.</p>
        </div>

        <!-- ➕ 리뷰 작성 버튼 -->
        <div class="write-btn-box">
            <a href="#" id="write-btn">
                <button>리뷰 작성하기</button>
            </a>
        </div>
    </div>

</div>

</body>
</html>
