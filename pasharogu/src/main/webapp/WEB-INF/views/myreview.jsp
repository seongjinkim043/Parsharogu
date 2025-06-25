<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<section class="reviews" id="reviews">
    <h2>マイリビュー</h2>

    <div class="review-scroll-container">
        <button class="arrow left" onclick="showPreviousReview()">◀</button>

        <div id="review-container" class="review-list">
            <!-- JS로 동적으로 채워질 영역 -->
        </div>

        <button class="arrow right" onclick="showNextReview()">▶</button>
    </div>
</section>