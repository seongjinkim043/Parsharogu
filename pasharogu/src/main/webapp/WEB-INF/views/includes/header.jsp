<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<style>
  .header {
    width: 1920px;
    padding: 35px 60px;
    box-sizing: border-box;
  }

  .header-inner {
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .logo {
    font-size: 36px;
    font-weight: bold;
    color: #2962FF;
    text-decoration: none;
    cursor: pointer;
  }

  .nav-menu {
    display: flex;
    gap: 30px;
    font-size: 16px;
  }

  .nav-menu a {
    text-decoration: none;
    color: #333;
    cursor: pointer;
  }
</style>

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