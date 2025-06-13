<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pa.dto.ReviewDTO" %>
<%@ page import="java.util.List" %>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>마이페이지 - 내 리뷰</title>
  <style>
    body { font-family: sans-serif; margin: 2rem; }
    .review-box {
      border: 2px solid #aaa;
      border-radius: 8px;
      padding: 1rem;
      margin-bottom: 1rem;
      background-color: #f9f9f9;
    }
    .rating { color: gold; font-size: 1.2rem; }
    .empty { color: gray; font-style: italic; }
  </style>
</head>
<body>
  <h2>내가 쓴 리뷰</h2>

  <%
    java.util.List<ReviewDTO> reviews = (java.util.List<ReviewDTO>) request.getAttribute("reviews");
    if (reviews == null || reviews.isEmpty()) {
  %>
    <p class="empty">아직 작성한 리뷰가 없습니다.</p>
  <%
    } else {
      for (ReviewDTO review : reviews) {
  %>
    <div class="review-box">
      <strong>📍 <%= review.getPlaceId() %></strong><br>
      <span class="rating">
        <%
          int rating = review.getRating();
          for (int i = 1; i <= rating; i++) out.print("★");
          for (int i = rating + 1; i <= 5; i++) out.print("☆");
        %>
      </span><br>
      <p>
        <%
          String content = review.getContent();
          if (content != null && content.length() > 50) {
            out.print(content.substring(0, 50) + "...");
          } else {
            out.print(content);
          }
        %>
      </p>
      <small><%= review.getCreatedDate() %></small>
    </div>
  <%
      }
    }
  %>

</body>
</html>
