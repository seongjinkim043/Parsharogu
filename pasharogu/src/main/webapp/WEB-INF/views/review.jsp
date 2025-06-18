<%@ page contentType="text/html; charset=UTF-8" %>

<div class="review-panel">
  <!-- 지역 정보 -->
  <div class="region-info">
    <div class="region-thumbnail">
      <img src="지역이미지URL" alt="지역 썸네일">
    </div>
    <div class="region-details">
      <div class="region-name-rating">
        <div class="region-name">地域名</div>
        <div class="region-rating">
          <span class="score">5.0</span>
          <span class="stars">★★★★★</span>
        </div>
      </div>
      <div class="region-desc">Lorem Ipsum is simply dummy textLorem Ipsum is simply dummy textLorem Ipsum is simply dummy text</div>
    </div>
    <button class="favorite-btn">❤</button>
  </div>

  <!-- 리뷰 리스트 -->
  <div class="review-list">
    <div class="review-item">
      <div class="review-header">
        <div class="user-section">
          <img src="유저이미지URL" alt="유저사진" class="user-photo">
          <div class="user-info">
            <span class="user-name">USER NAME</span>
            <span class="review-date">2025.06.17</span>
            <div class="review-rating">
              <span class="score">5.0</span>
              <span class="stars">★★★★★</span>
            </div>
          </div>
        </div>
      </div>
      <div class="review-content">
        Lorem Ipsum is simply dummy text of the printing and typesetting industry. 
        Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.
      </div>
      <div class="review-images">
        <img src="리뷰이미지1URL" alt="리뷰이미지">
        <img src="리뷰이미지2URL" alt="리뷰이미지">
        <img src="리뷰이미지3URL" alt="리뷰이미지">
      </div>
    </div>
    <!-- 추가 리뷰 반복 -->
  </div>

  <!-- 작성 버튼 -->
  <div class="review-write-btn">
    <button>＋</button>
  </div>
</div>
