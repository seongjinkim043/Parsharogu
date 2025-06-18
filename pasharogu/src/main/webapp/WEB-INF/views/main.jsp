<%-- <%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<html>
<head>
    <title>パシャログ</title>
	<link rel="stylesheet" href="/css/main.css">
</head>
<body>
	<%@ include file="map.jsp" %>
</body>
</html>
 --%> 
 
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<html>
<head>
    <title>パシャログ</title>
    <link rel="stylesheet" href="/css/main.css">
    <style>
        .container {
            display: flex;
            height: 100vh;
        }
        .map-area {
            width: 60%;
            overflow: hidden;
        }
        .region-info {
            width: 40%;
            padding: 20px;
            overflow-y: auto;
            background: #f9f9f9;
            border-left: 1px solid #ccc;
        }
        #region-summary h2 {
            font-size: 24px;
            margin-bottom: 5px;
        }
        .review-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 5px #ccc;
            padding: 10px;
            margin: 10px 0;
        }
        .review-header {
            font-weight: bold;
            display: flex;
            justify-content: space-between;
        }
        .review-images img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            margin-right: 5px;
            border-radius: 4px;
        }
    </style>
</head>
<body>

<div class="container">
    <!-- ① 지도 영역 -->
    <div class="map-area">
        <%@ include file="map.jsp" %>
    </div>

    <!-- ②~⑥ 오른쪽 지역 정보 + 리뷰 -->
    <div class="region-info">
        <!-- ② 지역명 + 평점 -->
        <div id="region-summary">
            <h2>지역명 <span>0.0 ★</span></h2>
            <p>지역을 선택해주세요.</p>
        </div>

        <!-- ④~⑤ 리뷰 리스트 -->
        <div id="review-list">
            <p>리뷰를 불러오는 중...</p>
        </div>

        <!-- ⑥ 더보기 버튼 -->
        <div style="text-align: center; margin-top: 20px;">
            <button id="load-more">＋</button>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function loadRegion(name) {
    // 지역 설명 불러오기
    $.ajax({
        url: '/region/info',
        data: { region: name },
        success: function(data) {
            $('#region-summary').html(`
                <h2>${data.name} <span>${data.rating} ★</span></h2>
                <p>${data.description}</p>
            `);
        }
    });

    // 리뷰 리스트 불러오기
    $.ajax({
        url: '/api/reviews/list',
        data: { region: name },
        success: function(data) {
            let html = '';
            if (data.length === 0) {
                html = '<p>등록된 리뷰가 없습니다.</p>';
            } else {
                for (let review of data) {
                    html += `
                        <div class="review-card">
                            <div class="review-header">
                                <span>${review.username}</span>
                                <span>${review.date}</span>
                                <span>${review.rating} ★</span>
                            </div>
                            <div class="review-content">
                                <p>${review.content}</p>
                                html += `<div class="review-images">` +
                                (review.imagePaths || []).map(path => `<img src="${path}" />`).join('') +
                                `</div>`
                            </div>
                        </div>
                    `;
                }
            }
            $('#review-list').html(html);
        }
    });
}

// SVG 클릭 이벤트에서 호출될 함수
$(document).on('click', '.region', function () {
    const regionName = $(this).data('label');
    loadRegion(regionName);
});
</script>

</body>
</html>