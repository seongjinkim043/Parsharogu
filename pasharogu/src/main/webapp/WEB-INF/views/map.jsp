<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="map-area" style="width:100%; height:100vh; overflow:hidden; position:relative;">
  <svg id="region-map" viewBox="0 0 1000 1000" xmlns="http://www.w3.org/2000/svg" style="width:100%; height:100%;">
    <c:forEach var="region" items="${regions}">
      <path class="region"
            d="${region.svgId}" 
            data-id="${region.regionId}"
            data-label="${region.name}"
            fill="#888"
            stroke="#fff"
            style="cursor:pointer;" />
    </c:forEach>
  </svg>
</div>