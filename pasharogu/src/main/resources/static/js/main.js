document.addEventListener("DOMContentLoaded", function() {
  const urlParams = new URLSearchParams(window.location.search);
  const regionId = urlParams.get('region');
  console.log("리뷰 페이지 regionId:", regionId);

  if (regionId) {
    loadReviewPanel(regionId);
  }

  // 지도 hover + 클릭 처리
  document.querySelectorAll('.region').forEach(function(path) {
    path.addEventListener('mouseenter', function(e) {
      const tooltip = document.getElementById('region-tooltip');
      tooltip.textContent = this.getAttribute('data-label');
      tooltip.style.display = 'block';
      this.parentNode.appendChild(this);
    });

    path.addEventListener('mousemove', function(e) {
      const tooltip = document.getElementById('region-tooltip');
      tooltip.style.left = (e.pageX + 10) + 'px';
      tooltip.style.top = (e.pageY + 10) + 'px';
    });

    path.addEventListener('mouseleave', function() {
      const tooltip = document.getElementById('region-tooltip');
      tooltip.style.display = 'none';
    });

    path.addEventListener('click', function() {
      const regionId = this.getAttribute('data-id');
      if (!regionId) {
        alert("지역 ID가 없습니다.");
        return;
      }
      loadReviewPanel(regionId);
    });
  });
});

// review.html + region info 로드
function loadReviewPanel(regionId) {
  fetch('/fragment/review.html')
    .then(response => {
      if (!response.ok) throw new Error(`HTTP error: ${response.status}`);
      return response.text();
    })
    .then(html => {
      const reviewPanel = document.getElementById('review-panel');
      reviewPanel.innerHTML = html;
      reviewPanel.style.display = 'block';

      loadRegionInfo(regionId);
    })
    .catch(error => {
      console.error("리뷰 패널 로드 실패", error);
      alert("리뷰 패널을 불러오는 데 실패했습니다.");
    });
}

// region info + 리뷰 데이터 로드
function loadRegionInfo(regionId) {
  const encodedRegion = encodeURIComponent(regionId);
  console.log("encodedRegion:", encodedRegion);

  fetch(`/region/info?region=${encodedRegion}`)
    .then(response => {
      if (!response.ok) throw new Error(`HTTP error: ${response.status}`);
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

      // 리뷰 리스트 채우기
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
      console.error("지역 정보 로드 실패", error);
      alert("지역 정보를 불러오는 데 실패했습니다.");
    });
}
