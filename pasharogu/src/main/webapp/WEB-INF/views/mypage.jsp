<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
	<head>
		<title>マイページ</title>
		<link rel="stylesheet" href="/css/mypage.css">
	</head>
<body>
	<%@ include file="/WEB-INF/views/includes/header.jsp" %>

	<div class="container">
		 <section class="profile">
			  <div class="userInfo">
				  	<c:choose>
					  <c:when test="${not empty loginUser.profileImg}">
					    <img class="profileImg" src="${loginUser.profileImg}" alt="プロフィール画像">
					  </c:when>
					  <c:otherwise>
					    <img src="/img/default_profile.svg" alt="デフォルトプロフィール画像">
					  </c:otherwise>
					</c:choose>
			    <h2>${loginUser.nickname}</h2>
			    <button class="nickname-btn" onclick="handleClick()"></button>
			  </div>
			
			  <div class="reviewcounter">
			    <div>レビュー地域　: <strong>${reviewCount}</strong>&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;
			    行きたい　: <strong>${ikitaiCount}</strong></div>
			  </div>
		</section>
	<hr class="profileline" /> 
		
		<div class="wrapper">
		    <div class="top-row">
		        <section class="calendar">
		           <div class="calendar-embed-wrapper"></div>
		            <div>
					  <c:forEach var="item" items="index.jsp">
					    <li class="calendar-item">
					      <div class="calendar-box">
					        <jsp:include page="/index" />
					      </div>
					    </li>
					  </c:forEach>
					</div>
		        </section>
		
				<section class="myreview">
				  	<jsp:include page="myreview.jsp" />
				</section>

			  </div>
  
		      <div class="ikitai-review">		  
				    <jsp:include page="myikitai.jsp" />
			  </div>
		</div>	  
	</div>

	<script src="/js/mypage.js" defer></script>
</body>
</html>