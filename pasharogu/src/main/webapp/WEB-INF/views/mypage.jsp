<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

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
		    border: 1px solid #ccc;
		    padding: 15px;
		    box-sizing: border-box;
		}

		.review-list {
		    display: flex;
		    justify-content: center; /* 리뷰 아이템들을 가운데 정렬 */
		    overflow-x: auto;
		    gap: 15px; /* 리뷰 사이 간격 */
		    padding-top: 10px;
		}

		.review-item {
		    flex-shrink: 0;
		    width: 800px;
		    padding: 10px;
		    border: 1px solid #ddd;
		    border-radius: 15px;
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
		.ikitai-wrapper {
		    margin-top: 40px;
		    position: relative;
		}

		.ikitai-list {
		    display: flex;
		    overflow-x: auto;
		    gap: 15px;
		    padding: 10px 0;
		    scroll-behavior: smooth;
		}

		.ikitai-card {
		    flex-shrink: 0;
		    width: 150px;
		    background: white;
		    border-radius: 10px;
		    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
		    text-align: center;
		    padding-bottom: 10px;
		    position: relative;
		}

		.ikitai-card img {
		    width: 100%;
		    height: 100px;
		    object-fit: cover;
		    border-top-left-radius: 10px;
		    border-top-right-radius: 10px;
		}

		.ikitai-card .info {
		    padding: 8px;
		}

		.place-name {
		    font-weight: bold;
		    margin-bottom: 4px;
		}

		.rating {
		    font-size: 0.9em;
		    color: #f39c12;
		}

		.heart {
		    cursor: pointer;
		    font-size: 20px;
		    transition: transform 0.2s;
		}
		.heart.on { color: red; }
		.heart.off { color: gray; }

    </style>
</head>
<body>
	<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<div class="container">
    <h1>マイページ</h1>

    <div class="top-row">
        <section class="calendar">
            <h2>カレンダー</h2>
           <div class="calendar-embed-wrapper">
    
  </div>
            <ul>
  <c:forEach var="item" items="${calendar}">
    <li class="calendar-item">
      <div class="calendar-box">
        <jsp:include page="/index" />
      </div>
    </li>
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
		<section class="ikitai-wrapper">
		    <h2>行きたい</h2>
		    <p>旅行先候補をリストアップ！</p>

		    <button class="arrow left" onclick="scrollIkitaiLeft()">&#9664;</button>
		    <div class="ikitai-list" id="ikitaiList">
		        <c:forEach var="ikitai" items="${ikitaiList}">
		            <div class="ikitai-card">
		                <a href="/ikitai/go?region=${ikitai.regionName}">
		                    <img src="${ikitai.imageUrl}" alt="${ikitai.regionName}" />
		                </a>
		                <div class="info">
		                    <div class="region-name">${ikitai.regionName}</div>
		                    <div class="rating">5.0 ★★★★★</div> <!-- 임시로 고정 -->
							<div class="heart" onclick="toggleIkitai(this, '${ikitai.placeId}')">
							    ${ikitai.liked ? '❤️' : '🤍'}
							</div>


		                </div>
		            </div>
		        </c:forEach>
		    </div>
		    <button class="arrow right" onclick="scrollIkitaiRight()">&#9654;</button>
		</section>

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
	function scrollIkitaiLeft() {
	    const container = document.getElementById('ikitaiList');
	    container.scrollBy({ left: -220, behavior: 'smooth' });
	}

	function scrollIkitaiRight() {
	    const container = document.getElementById('ikitaiList');
	    container.scrollBy({ left: 220, behavior: 'smooth' });
	}

	function toggleIkitai(el, regionId) {
	    fetch('/ikitai/toggle', {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/x-www-form-urlencoded'
	        },
	        body: 'regionId=' + regionId
	    })
	    .then(response => response.text())
	    .then(result => {
	        if (result === 'added') {
	            el.textContent = '❤️';
	        } else {
	            el.textContent = '🤍';
	        }
	    });
	}

</script>
</body>
</html>