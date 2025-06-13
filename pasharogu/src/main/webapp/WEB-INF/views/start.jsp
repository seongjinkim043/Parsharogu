<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="UTF-8">
    <title>パシャログ</title>
    <style>
		html, body {	//페이지 사이즈 고정
		  width: 100%;
		  height: 100%;
		  margin: 0;
		  overflow: hidden;
		}
      .container {
        display: flex;	
        justify-content: space-between;
        align-items: center;
		height: 956px;
        padding: 0 240px 140px 240px;
		box-sizing: border-box;
      }
	  
	  .left-content{
		max-width: 45%;
		margin-bottom: 60px;
	  }

      .title {
        font-size: 60px;
        font-weight: bold;
        margin-bottom: 60px;
        line-height: 1.4;
      }

      .desc {
        color: #666;
        font-size: 14px;
        margin-bottom: 100px;
      }

      .btn {
		width: 160px;
		height: 48px;
        padding: 1px 24px;
        font-size: 16px;
        background-color: #89b5ff;
        color: white;
        border: none;
        border-radius: 5cap;
        cursor: pointer;
      }

      .right-image {
        max-width: 50%;
      }

      .right-image img {
        width: 100%;
        height: auto;
        margin-bottom: 100px;
      }
    </style>
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
        <a href="/map"><button class="btn">地図を見る</button></a>
      </div>

      <div class="right-image">
        <img src="/img/show.svg" alt="show" />
      </div>
    </div>

  </body>
</html>
