let reviews = [];
let currentIndex = 0;

document.addEventListener('DOMContentLoaded', () => {
  fetchMyReviews();
});

function fetchMyReviews() {
  fetch('/myreviews')
    .then(res => res.json())
    .then(data => {
      reviews = data;
      currentIndex = 0;
      if (reviews.length > 0) {
        renderReview(currentIndex);
      } else {
        document.getElementById('review-container').innerHTML = "<div class='no-reviews'>아직 리뷰가 없습니다.</div>";
      }
    })
    .catch(() => {
      document.getElementById('review-container').innerHTML = "<div class='no-reviews'>리뷰 불러오기 실패</div>";
    });
}

function renderReview(index) {
  const review = reviews[index];
  const container = document.getElementById('review-container');
  container.innerHTML = '';

  let imageHtml = '';
  if (review.imageUrls && review.imageUrls.length > 0) {
    imageHtml = review.imageUrls.map(url => `<img src="${url}" alt="리뷰 이미지" class="review-image">`).join('');
  }

  // ⭐ 별점 시각화 추가
   const rating = review.rating || 0;
   const fullStars = Math.floor(rating);
   const halfStar = rating % 1 >= 0.5 ? 1 : 0;
   const emptyStars = 5 - fullStars - halfStar;

   const starHtml =
     '★'.repeat(fullStars) +
     (halfStar ? '☆' : '') +
     '✩'.repeat(emptyStars);
	 
  const item = document.createElement('div');
  item.className = 'review-item';
  item.innerHTML = `
    <div class="review-header">
	  <span class="review-region">${review.regionName || ''}</span>&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;
      <span class="review-date">${(review.date || '').substring(0, 10)}</span>&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;
      <span class="review-rating">${(review.rating || 0).toFixed(1)} <span class="stars">${starHtml}</span></span><br>
    </div>
	<div class="review-scroll-container">
	    <div class="review-content">${review.content || ''}</div><br>
	    <div class="review-images">${imageHtml}</div>
	</div>
  `;

  container.appendChild(item);
}

function showNextReview() {
  if (currentIndex < reviews.length - 1) {
    currentIndex++;
    renderReview(currentIndex);
  }
}

function showPreviousReview() {
  if (currentIndex > 0) {
    currentIndex--;
    renderReview(currentIndex);
  }
}


// 다음 리뷰 보기(순환)
function showNextReview() {
  if (currentIndex >= reviews.length - 1) {
    currentIndex = 0;  // 마지막에서 첫 번째로 순환
  } else {
    currentIndex++;
  }
  renderReview(currentIndex);
}
//이전 리뷰 보기(순환)
function showPreviousReview() {
  if (currentIndex <= 0) {
    currentIndex = reviews.length - 1;  // 첫 번째에서 마지막으로 순환
  } else {
    currentIndex--;
  }
  renderReview(currentIndex);
}

// 이하 기존 함수 유지

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
	            'Content-Type': 'application/json'   // ✅ 수정
	        },
	        body: JSON.stringify({ regionId: regionId })  // ✅ 수정
	    })
	    .then(response => response.text())
	    .then(result => {
	        console.log('Toggle result:', result);

	        if (result === 'added') {
	            el.textContent = '❤️';
	        } else if (result === 'removed') {
	            const card = el.closest('.ikitai-card');
	            card.style.transition = 'opacity 0.15s ease';
	            card.style.opacity = '0';
	            setTimeout(() => {
	                card.remove();
	                // ✅ 카운트 숫자 줄이기
	                const countEl = document.querySelector('.profile strong:last-child');
	                if (countEl) {
	                    let count = parseInt(countEl.textContent);
	                    if (!isNaN(count) && count > 0) {
	                        countEl.textContent = count - 1;
	                    }
	                }
	            }, 500);
	        }
	    });
	}

function handleClick() {
  alert('マイプロフィールに移動しますか？');
}
