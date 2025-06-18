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
	                <option value="5">5</option>
	                <option value="4">4</option>
	                <option value="3">3</option>
	                <option value="2">2</option>
	                <option value="1">1</option>
	            </select>
	        </label>
	        <br><br>
	        <label>리뷰 내용:</label><br>
	        <textarea name="content" rows="5" cols="30" required></textarea>
	        <br><br>
	        <button type="submit">작성</button>
	    </form>
	</div>
</div>

<script>
document.querySelectorAll('.region').forEach(function(path) {
  path.addEventListener('mouseenter', function(e) {
    const tooltip = document.getElementById('region-tooltip');
    tooltip.textContent = this.getAttribute('data-label');
    tooltip.style.display = 'block';
    this.parentNode.appendChild(this);  // mapGroup ë´ìì z-order ìµìë¨ì¼ë¡
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
});

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

  // ✅ 클릭 시 폼 보여주기
  path.addEventListener('click', function() {
    const regionId = this.getAttribute('data-id');
    const regionName = this.getAttribute('data-label');

    document.getElementById('region-id-input').value = regionId;
    document.getElementById('region-name-title').textContent = regionName + ' 리뷰 작성';
    document.getElementById('review-form').style.display = 'block';
  });
});


</script>
