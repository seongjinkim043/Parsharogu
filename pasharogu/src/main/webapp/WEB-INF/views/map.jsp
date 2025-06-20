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
