<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>마이페이지</title>
    <style>
        .container {
            width: 90%;
            margin: 20px auto;
            font-family: Arial, sans-serif;
        }

        .top-row {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }

        .calendar {
            flex: 1;
            border: 1px solid #ccc;
            padding: 15px;
            box-sizing: border-box;
        }

        .review-wrapper {
            flex: 1;
            position: relative;
            display: flex;
            align-items: center;
        }

        .reviews {
            flex: 1;
            border: 1px solid #ccc;
            padding: 15px;
            box-sizing: border-box;
            overflow-x: auto;
            white-space: nowrap;
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

        .review-images {
            display: flex;
            gap: 5px;
            margin-top: 8px;
        }

        .review-images img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        .arrow {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            z-index: 10;
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            font-size: 18px;
            cursor: pointer;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .arrow.left {
            left: -15px;
        }

        .arrow.right {
            right: -15px;
        }

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
    <h1>マイページ</h1>

    <div class="top-row">
        <section class="calendar">
            <h2>カレンダー</h2>
            <ul>
                <c:forEach var="item" items="${calendar}">
                    <li>${item.date} - ${item.event}</li>
                </c:forEach>
            </ul>
        </section>

        <div class="review-wrapper">
            <button class="arrow left" onclick="scrollLeft()">&#9664;</button>
            <section class="reviews" id="reviews">
                <h2>マイリビュー</h2>
                <c:forEach var="review" items="${reviews}">
                    <div class="review-item">
                        日付: ${review.createdDate} <br/>
                        地域: ${review.placeId} <br/>
                        評点: ${review.rating} <br/>
                        コメント: ${review.content} <br/>
                        <div class="review-images">
                            <c:forEach var="img" items="${review.imageUrls}">
                                <img src="${img}" alt="レビュー画像" />
                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>
            </section>
            <button class="arrow right" onclick="scrollRight()">&#9654;</button>
        </div>
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

<script>
    function scrollLeft() {
        const container = document.getElementById('reviews');
        container.scrollBy({ left: -220, behavior: 'smooth' });
    }

    function scrollRight() {
        const container = document.getElementById('reviews');
        container.scrollBy({ left: 220, behavior: 'smooth' });
    }
</script>
</body>
</html>
