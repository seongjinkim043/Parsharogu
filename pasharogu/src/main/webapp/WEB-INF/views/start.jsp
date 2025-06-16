<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="UTF-8">
    <title>パシャログ</title>
	<link rel="stylesheet" href="/css/start.css">
  </head>
  <body>
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
