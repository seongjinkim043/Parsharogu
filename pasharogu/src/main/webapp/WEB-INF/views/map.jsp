<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<div class="map-area" style="overflow: visible; display: flex;">
  <!-- 지도 영역 -->
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

  <!-- 지역 클릭 시 보여지는 리뷰 폼 -->
  <div id="review-form" style="margin-left: 20px; display: none; width: 300px; border: 1px solid #ccc; padding: 15px; background: #fff;">
    <h3 id="region-name-title"></h3>
    <form method="post" action="/api/reviews/write" enctype="multipart/form-data">
      <input type="hidden" name="regionId" id="region-id-input" />

      <label>별점: 
        <select name="rating" required>
          <option value="5">★★★★★</option>
          <option value="4">★★★★</option>
          <option value="3">★★★</option>
          <option value="2">★★</option>
          <option value="1">★</option>
        </select>
      </label>
      <br><br>

      <label>리뷰 내용:</label><br>
      <textarea name="content" rows="5" cols="30" required></textarea>
      <br><br>

      <label>이미지 첨부:</label>
      <input type="file" name="images" multiple>
      <br><br>

      <button type="submit">작성</button>
    </form>
  </div>

  <!-- 툴팁 -->
  <div id="region-tooltip" style="position: absolute; display: none; background: rgba(0,0,0,0.75); color: white; padding: 5px 10px; border-radius: 5px; font-size: 13px; pointer-events: none;"></div>
</div>

<script>
  // 모든 지역 경로(path)에 대해 이벤트 등록
  document.querySelectorAll('.region').forEach(function(path) {
    path.addEventListener('mouseenter', function(e) {
      const tooltip = document.getElementById('region-tooltip');
      tooltip.textContent = this.getAttribute('data-label');
      tooltip.style.display = 'block';
      this.parentNode.appendChild(this);  // z-index처럼 위로 올림
    });

    path.addEventListener('mousemove', function(e) {
      const tooltip = document.getElementById('region-tooltip');
      tooltip.style.left = (e.pageX + 10) + 'px';
      tooltip.style.top = (e.pageY + 10) + 'px';
    });

    path.addEventListener('mouseleave', function() {
      document.getElementById('region-tooltip').style.display = 'none';
    });

    // ✅ 클릭 시 리뷰 폼에 값 채우고 표시
    path.addEventListener('click', function() {
      const regionId = this.getAttribute('data-id');
      const regionName = this.getAttribute('data-label');

      document.getElementById('region-id-input').value = regionId;
      document.getElementById('region-name-title').textContent = regionName + ' 리뷰 작성';
      document.getElementById('review-form').style.display = 'block';
    });
  });
</script>
