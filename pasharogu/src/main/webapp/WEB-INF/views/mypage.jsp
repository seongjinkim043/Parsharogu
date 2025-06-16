<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
    <title>마이페이지</title>
    <style>
        /* 전체 컨테이너 */
        .container {
            width: 90%;
            margin: 20px auto;
            font-family: Arial, sans-serif;
        }

        /* 상단 영역: 달력 + 리뷰 */
        .top-row {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }

        /* 달력 */
        .calendar {
            flex: 1;
            border: 1px solid #ccc;
            padding: 15px;
            box-sizing: border-box;
        }

        /* 리뷰: 가로 스크롤 가능 */
        .reviews {
            flex: 1;
            border: 1px solid #ccc;
            padding: 15px;
            box-sizing: border-box;
            overflow-x: auto;
            white-space: nowrap; /* 가로 줄 유지 */
        }

        .review-item {
            display: inline-block;
            width: 200px;
            margin-right: 15px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            vertical-align: top;
            background: #f9f9f9;
        }

        /* 아래 영역: 위시리스트 */
        .wishlist {
            border: 1px solid #ccc;
            padding: 15px;
            box-sizing: border-box;
        }

        .wishlist-item {
            padding: 5px 0;
            border-bottom: 1px solid #eee;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>마이페이지</h1>

    <div class="top-row">
        <section class="calendar">
            <h2>カレンダー</h2>
            <ul>
                <c:forEach var="item" items="${calendar}">
                    <li>${item.date} - ${item.event}</li>
                </c:forEach>
            </ul>
        </section>

        <section class="reviews">
            <h2>マイリビュー</h2>
            <c:forEach var="review" items="${reviews}">
                <div class="review-item">
                    <strong>${review.product}</strong><br/>
                    평점: ${review.rating} <br/>
                    코멘트: ${review.comment}
                </div>
            </c:forEach>
        </section>
    </div>

    <section class="wishlist">
        <h2>行きたい</h2>
        <ul>
            <c:forEach var="wish" items="${wishlist}">
                <li class="wishlist-item">${wish.item}</li>
            </c:forEach>
        </ul>
    </section>
</div>
</body>
</html>
