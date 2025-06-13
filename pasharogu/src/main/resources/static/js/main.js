function loadRegion(regionName) {
    // 지역 정보 불러오기
    $.ajax({
        url: '/region/info',
        data: { region: regionName },
        success: function(data) {
            $('#region-summary').html(`
                <h2>${data.name} <span>${data.rating} ★</span></h2>
                <p>${data.description}</p>
            `);
            $('#write-btn').attr('href', '/diary/write.jsp?region=' + regionName);
        }
    });

    // 리뷰 리스트 불러오기
    $.ajax({
        url: '/review/list',
        data: { region: regionName },
        success: function(data) {
            let html = '<ul>';
            if (data.length === 0) {
                html += '<li>등록된 리뷰가 없습니다.</li>';
            } else {
                for (let review of data) {
                    html += `<li>${review.username}: ${review.content} (${review.rating}★)</li>`;
                }
            }
            html += '</ul>';
            $('#review-list').html(html);
        }
    });
}
