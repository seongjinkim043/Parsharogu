<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<html>
<head>
	<title>パシャログ</title>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;700&family=Noto+Sans+JP:wght@400;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"> 
	<link rel="stylesheet" href="/css/main.css">
</head>
<body>
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
							<span class="stars"><i class="fa-solid fa-star"></i></span>
							<span class="score"></span>
						</div>
					</div>
					<div class="region-desc"></div>
				</div>
				<button class="favorite-btn" data-region-id="${region.regionId}" data-login="${not empty sessionScope.loginUser}">
					<i class="fas fa-heart"></i>
				</button>
			</div>
		
			<!-- 리뷰 리스트 -->
			<div class="review-list">
				<!-- JS로 리뷰 항목 추가 -->
			</div>
		
			<!-- 리뷰 작성 버튼 -->
			<div class="review-write-btn">
				<button id="review-write-btn" 
			          data-region-id="${region.regionId}"
			          data-login="${not empty sessionScope.loginUser}">
			  		<i class="fas fa-plus"></i>
				</button>
			</div>
		</div>
	</div>
	<div class="modal-overlay"></div>
	
	<!-- 리뷰 작성 모달 -->
	<div id="review-modal" class="review-modal" style="display: none;">
	  <div class="review-modal-content">
	    <div class="review-modal-header">
	      <span class="review-modal-title"><span id="modal-region-name"></span>は…</span>
	      <div class="review-stars">
	        <span data-value="1"><i class="fa-solid fa-star"></i></span>
	        <span data-value="2"><i class="fa-solid fa-star"></i></span>
	        <span data-value="3"><i class="fa-solid fa-star"></i></span>
	        <span data-value="4"><i class="fa-solid fa-star"></i></span>
	        <span data-value="5"><i class="fa-solid fa-star"></i></span>
	      </div>
	    </div>
	    <textarea id="review-text" placeholder="리뷰 내용을 작성해주세요"></textarea>
	    <label class="review-image-upload">
		  <input type="file" id="review-image" name="review-image" multiple>
	    </label>
	    <button id="review-submit">등록</button>
	    <button class="review-modal-close">
			<i class="fas fa-times"></i>
		</button>
	  </div>
	</div>
	
	<script src="/js/main.js" defer></script>
</body>
</html>