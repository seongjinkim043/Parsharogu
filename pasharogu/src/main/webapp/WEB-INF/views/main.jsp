<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>
	<title>パシャログ</title>
	<link rel="stylesheet" href="/css/main.css">
</head>
<body>
	<%@ include file="/WEB-INF/views/includes/header.jsp" %>
	<div class="container">
		<!-- 지도 -->
		<div class="map-panel">
			<div class="map-area" style="overflow: visible;">
				<svg id="region-map" width="820px" height="758px" viewBox="0 0 820 758" preserveAspectRatio="xMidYMid meet" xmlns="http://www.w3.org/2000/svg">
					<g id="map-group">
						<c:forEach var="region" items="${regions}">
							<path class="region"
							d="${region.svgId}" 
							data-id="${region.regionId}"
							data-label="${region.name}" />
						</c:forEach>
					</g>
				</svg>
			</div>
			<div id="region-tooltip" class="region-tooltip"></div>
		</div>
			
		<div class="review-panel" id="review-panel">
			<!-- 지역 정보 -->
			<div class="region-info">
			<!-- 기본 썸네일 -->
				<div class="region-thumbnail">
				<img src="/img/basic.jpg" alt="지역 썸네일"> 
				</div>
				<div class="region-details">
					<div class="region-name-rating">
						<div class="region-name"></div>
						<div class="region-rating">
							<span class="score"></span>
							<span class="stars"></span>
						</div>
					</div>
					<div class="region-desc"></div>
				</div>
				<button class="favorite-btn" data-region-id="${region.regionId}" }>❤</button>
			</div>
		
			<!-- 리뷰 리스트 -->
			<div class="review-list">
				<!-- JS로 리뷰 항목 추가 -->
			</div>
		
			<!-- 리뷰 작성 버튼 -->
			<div class="review-write-btn">
				<button>＋</button>
			</div>
		</div>
	</div>
	  <script src="/js/main.js" defer></script>
</body>
</html>