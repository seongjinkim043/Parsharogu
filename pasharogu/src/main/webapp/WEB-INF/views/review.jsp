<%@ page contentType="text/html; charset=UTF-8" %>

<div id="review-box" style="display: none; border: 1px solid #ccc; padding: 20px; width: 600px; margin-top: 20px; background: #fff; border-radius: 8px;">
  
  <!-- 상단 (지역명, 별점, 아이콘) -->
  <div style="display: flex; align-items: center; justify-content: space-between;">
    <div style="display: flex; align-items: center;">
      <div style="width: 60px; height: 60px; background: #ccc; border-radius: 8px; margin-right: 10px;"></div> <!-- 지역 이미지 자리 -->
      <div>
        <div style="font-size: 24px; font-weight: bold;" id="region-name">地域</div>
        <div style="font-size: 16px;"><span id="region-rating">0.0</span> ★★★★★</div>
      </div>
    </div>
    <div>
      <img src="heart_icon.png" alt="좋아요" style="width: 24px; height: 24px;">
    </div>
  </div>

  <!-- 설명 -->
  <p id="region-desc" style="margin-top: 10px;">
    説明がここに入ります。
  </p>

  <!-- 사용자 리뷰 -->
  <div id="user-reviews" style="margin-top: 20px;">
    <%-- JS로 생성되는 영역 --%>
  </div>

</div>
