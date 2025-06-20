<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>パシャログ</title>
	<link rel="stylesheet" href="/css/main.css">
</head>
<body>
<div class="review-panel">
  <!-- 지역 정보 -->
  <div class="region-info">
    <div class="region-thumbnail">
      <!-- 지역 썸네일: fetch에서 src 지정, 없으면 기본 이미지 -->
      <img src="기본지역이미지.jpg" alt="지역 썸네일">
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
    <button class="favorite-btn">❤</button>
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

<script>
	document.addEventListener("DOMContentLoaded", function() {
	  const urlParams = new URLSearchParams(window.location.search);
	  const regionId = urlParams.get('region');
	  console.log("리뷰 페이지 regionId:", regionId);

	  if (!regionId) {
	    alert("지역 정보가 없습니다.");
	    window.location.href = "/";  // 메인이나 다른 안전한 페이지로 리다이렉트
	    return;
	  }
	  
	  const encodedRegion = encodeURIComponent(regionId);
	  console.log("encodedRegion:", encodedRegion);
	  fetch(`/region/info?region=\${encodedRegion}`)
	    .then(response => {
	      if (!response.ok) {
	        throw new Error(`HTTP error: ${response.status}`);
	      }
	      return response.json();
	    })
	    .then(data => {
	      console.log("응답 데이터:", data);

	      if (data.error) {
	        alert(data.error);
	        return;
	      }

	      // 지역 정보 채우기
	      document.querySelector(".region-name").textContent = data.name || "이름 없음";
	      document.querySelector(".region-desc").textContent = data.description || "설명 없음";
	      document.querySelector(".score").textContent = (data.avgScore || 0).toFixed(1);
	      document.querySelector(".stars").textContent = "★".repeat(Math.round(data.avgScore || 0));

	      const regionImg = document.querySelector(".region-thumbnail img");
	      regionImg.src = data.thumbnailUrl || "기본지역이미지.jpg";
	      regionImg.alt = (data.name || "지역") + " 썸네일";

	      // 리뷰 리스트
	      const reviewList = document.querySelector(".review-list");
	      reviewList.innerHTML = "";

	      if (data.reviews && data.reviews.length > 0) {
	        data.reviews.forEach(review => {
	          const reviewItem = document.createElement("div");
	          reviewItem.className = "review-item";

	          const imageHtml = (review.imageUrls || []).map(function(url) {
	            return `<img src="${url}" alt="리뷰이미지">`;
	          }).join('');

	          reviewItem.innerHTML = `
	            <div class="review-header">
	              <div class="user-section">
	                <img src="\${review.userImageUrl || '기본유저.jpg'}" alt="유저사진" class="user-photo">
	                <div class="user-info">
	                  <span class="user-name">\${review.userName || '익명'}</span>
	                  <span class="review-date">\${review.date || ''}</span>
	                  <div class="review-rating">
	                    <span class="score">\${(review.score || 0).toFixed(1)}</span>
	                    <span class="stars">\${'★'.repeat(Math.round(review.score || 0))}</span>
	                  </div>
	                </div>
	              </div>
	            </div>
	            <div class="review-content">\${review.content || ''}</div>
	            <div class="review-images">\${imageHtml}</div>
	          `;

	          reviewList.appendChild(reviewItem);
	        });
	      } else {
	        reviewList.innerHTML = "<div class='no-reviews'>리뷰가 없습니다.</div>";
	      }

	    })
	    .catch(error => {
	      console.error("JSON 파싱 실패", error);
	      alert("지역 정보를 불러오는 데 실패했습니다.");
	    });

});
</script>
</body>
</html>
