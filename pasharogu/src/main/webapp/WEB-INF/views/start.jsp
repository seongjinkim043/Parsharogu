<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>


<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="UTF-8">
    <title>パシャログ</title>
    <style>
      .container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-left: 240px;
        padding-right: 240px;
      }

      .title {
        font-size: 64px;
        font-weight: bold;
        margin-bottom: 47px;
        line-height: 1.4;
      }

      .desc {
        color: #666;
        font-size: 16px;
        margin-bottom: 120px;
      }

      .btn {
        padding: 12px 24px;
        font-size: 12px;
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
        margin-bottom: 200px;
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
          パシャログは、日本の地域ごとにユーザーが<br>
          レビューを投稿・閲覧できるサービスです。<br>
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
