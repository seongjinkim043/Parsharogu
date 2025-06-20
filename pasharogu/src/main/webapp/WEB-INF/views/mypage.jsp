<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
	<head>
		<title>マイページ</title>
<style>
        .container {
            width: 90%;
            margin: 10px auto;
            font-family: Arial, sans-serif;
        }

        .top-row {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
            
        }
        
        .nickname-btn {
		  width: 16px;
		  height: 16px;
		  background-color: #e0e0e0;  /* 옅은 회색 */
		  border: none;
		  border-radius: 3px;
		  cursor: pointer;
		  padding: 0;
		  margin-left: 10px;
		}
		
		.nickname-btn:hover {
		  background-color: #0056b3;
		}

        .calendar {
            flex: 1;
            border: 1px solid #ccc;
            padding: 15px;
            box-sizing: border-box;
            margin-left: 20px;
      
        }

        .review-wrapper {
            flex: 1;
            position: relative;
            display: block;
            align-items: center;
            margin-right: 20px;
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
		    cursor: pointer;
		    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    padding: 0;
		    border-radius: 50%;
		}

        .arrow.left {
            left: -15px;
        }

        .arrow.right {
            right: -15px;
        }

        .wishlist {
		  display: flex;
		  flex-wrap: wrap; /* 여러 줄 허용 */
		  border: 1px solid #ccc;
		  padding: 15px;
		  box-sizing: border-box;
		}

        .wishlist-item {
            padding: 5px 0;
            border-bottom: 1px solid #eee;
        }
		.ikitai-wrapper {
		  clear: both;
		  margin-top: 40px;
		  margin-left: 30px;
		  display: block;
		  width: auto;
		  max-width: 100%;
		  overflow-x: auto;
		  white-space: nowrap;
		  position: relative; /* 스크롤 버튼 위치용 */
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
	  <section class="profile" style="display: flex; align-items: center; margin-bottom: 30px; padding: 5px; border-radius: 10px;">
	    <c:if test="${not empty loginUser.profileImg}">
	      <img src="${loginUser.profileImg}" alt="プロフィール画像" style="width:100px; height:100px; border-radius: 50%; border: 1px solid #ccc; margin-right: 15px;">
	    </c:if>
	    <h2>${loginUser.nickname}</h2>
	    <button class="nickname-btn" onclick="handleClick()"></button>
	  </section>
	</div>
	
    <div class="top-row">
        <section class="calendar">
            <h2>カレンダー</h2>
           <div class="calendar-embed-wrapper"></div>
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
		    <jsp:include page="myreview.jsp" />
		    <button class="arrow right" onclick="scrollRight()">&#9654;</button>
	</div>


   
    
    <div class="ikitai-review">
		    <button class="arrow left" onclick="scrollLeft()">&#9664;</button>
		    <jsp:include page="myikitai.jsp" />
		    <button class="arrow right" onclick="scrollRight()">&#9654;</button>
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
	function handleClick() {
	    alert('マイプロフィールに移動しますか？');
	  }

</script>
</body>
</html>