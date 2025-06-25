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
			
			  <div style="text-align: right; font-size: 14px; margin-right: 20px;">
			    <div>レビュー地域　:　　 <strong>${reviewCount}</strong>
			    行きたい　: <strong>${ikitaiCount}</strong></div>
			  </div>
		</section>
	<hr style="border: none; border-top: 2px solid #ccc; margin: 0 0 30px 0;" /> 
		
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
				        <c:if test="${not empty reviews}">
						    <div class="review-wrapper">   
						        <jsp:include page="myreview.jsp" />
						    </div>
					    </c:if>
						
						<c:if test="${empty reviews}">
							<div class="review-wrapper">
						  	  <p style="padding: 40px; color: #666; font-size: 25px">レビューがありません。</p>
						    </div>
						</c:if>
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