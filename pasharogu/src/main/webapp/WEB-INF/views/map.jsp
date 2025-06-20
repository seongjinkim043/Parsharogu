<!-- 지도 만들기 -->
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
	<div id="region-tooltip" class="region-tooltip"></div>
</div>
<!-- hover할때 지역 이름 뜨기-->
<script>
	document.querySelectorAll('.region').forEach(function(path) {
	  path.addEventListener('mouseenter', function(e) {
	    const tooltip = document.getElementById('region-tooltip');
	    tooltip.textContent = this.getAttribute('data-label');
	    tooltip.style.display = 'block';
	    this.parentNode.appendChild(this); 
		
		path.addEventListener('click', function() {
		    const regionId = this.getAttribute('data-id');
		    window.location.href = '/review?region=' + encodeURIComponent(regionId);
		});
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
</script>