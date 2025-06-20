<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>
    <title>パシャログ</title>
	<link rel="stylesheet" href="/css/main.css">
<style>
    .container {
      display: flex;
    }
    .map-panel {
      width: 60%;
    }
    .review-panel {
      width: 40%;
      border-left: 1px solid #ccc;
      padding: 10px;
      display: none; /* 처음엔 숨김 */
    }
  </style>
</head>
<body>
  <%@ include file="/WEB-INF/views/includes/header.jsp" %>
  <div class="container">
    <div class="map-panel">
      <%@ include file="map.jsp" %>
    </div>
    <div class="review-panel" id="review-panel">
      <!-- review.html + 데이터가 JS로 채워짐 -->
    </div>
  </div>
  <script src="/js/main.js" defer></script>
</body>
</html>