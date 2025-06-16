<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/css/common.css">


<header class="header">
  <div class="header-inner">

    <!-- 로고 -->
    <a href="/main" class="logo">パシャログ</a>

    <!-- 내비게이션 -->
    <nav class="nav-menu">
      <a href="/mypage">マイページ</a>
      <c:choose>
        <c:when test="${not empty sessionScope.user}">
          <a href="/logout">ログアウト</a>
        </c:when>
        <c:otherwise>
          <a href="/login">ログイン</a>
        </c:otherwise>
      </c:choose>
    </nav>	

  </div>
</header>