<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


    <section class="reviews" id="reviews">
        <h2>マイリビュー</h2>
       <div class="review-scroll-container">
    <button class="arrow left" onclick="showPreviousReview()">◀</button>
    
            <c:forEach var="review" items="${reviews}">
                <div class="review-item">
                    日付: ${review.date} <br/>
                    地域: ${review.regionId} <br/>
                    評点: ${review.rating} <br/>
                    コメント: ${review.content} <br/>
                    <div class="review-images">
                        <c:forEach var="img" items="${review.imageUrls}">
                             <img src="${img}" alt="レビュー画像" style="width:100px; height:100px; object-fit: cover; border-radius: 8px;" />
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
        </div>
     <button class="arrow right" onclick="showNextReview()">▶</button>

</section>