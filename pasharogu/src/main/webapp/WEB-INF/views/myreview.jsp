<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<section class="reviews" id="reviews">
    <h1 style="margin:20px; font-size:32px;">マイリビュー</h1>
    <p style="margin:20px; color:gray;">自分のレビューを確認して、クリックで編集できます</p>

    <div class="review-scroll-container">
        <button class="arrow left" onclick="showPreviousReview()">◀</button>

        <div id="review-container" class="review-list">
            <!-- JS로 동적으로 채워질 영역 -->
        </div>

        <button class="arrow right" onclick="showNextReview()">▶</button>
    </div>
</section>