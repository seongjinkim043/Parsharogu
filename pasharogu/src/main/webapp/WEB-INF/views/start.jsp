<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="UTF-8">
    <title>パシャログ</title>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;700&family=Noto+Sans+JP:wght@400;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="/css/start.css">
  </head>
  <body>
	<%@ include file="/WEB-INF/views/includes/header.jsp" %>
    <div class="container">
      <div class="left-content">
        <div class="title">
          地域ごとに<br>
          感想を共有する、<br>
          レビュー地図サービス
        </div>
        <div class="desc">
          パシャログは、日本の地域ごと<br>
		  ユーザーがレビューを投稿・閲覧できるサービスです。<br>
          都道府県をクリックすることで<br>
		  その地域に関するレビューを見ることができます。
        </div>
        <a href="/main"><button class="btn">地図を見る</button></a>
      </div>

      <div class="right-image">
        <img src="/img/show.svg" alt="show" />
      </div>
    </div>

  </body>
</html>
