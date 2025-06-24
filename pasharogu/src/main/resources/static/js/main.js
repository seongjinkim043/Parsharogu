document.addEventListener("DOMContentLoaded", function() {
  const urlParams = new URLSearchParams(window.location.search);
  const regionId = urlParams.get('region');

  if (regionId) {
    loadReviewPanel(regionId);
  }

  document.querySelectorAll('.region').forEach(function(path) {
    path.addEventListener('mouseenter', function(e) {
      const tooltip = document.getElementById('region-tooltip');
      tooltip.textContent = this.getAttribute('data-label');
      tooltip.style.display = 'block';
      tooltip.style.left = (e.clientX + 5) + 'px';
      tooltip.style.top = (e.clientY - 25) + 'px';
      this.parentNode.appendChild(this);
    });

    path.addEventListener('mousemove', function(e) {
      const tooltip = document.getElementById('region-tooltip');
      tooltip.style.left = (e.clientX + 5) + 'px';
      tooltip.style.top = (e.clientY - 25) + 'px';
    });

    path.addEventListener('mouseleave', function() {
      const tooltip = document.getElementById('region-tooltip');
      tooltip.style.display = 'none';
    });

    path.addEventListener('click', function() {
      const regionId = this.getAttribute('data-id');
      if (!regionId) {
        alert("지역 ID가 없습니다.");
        return;
      }
      console.log(`지역 클릭됨: \${regionId}`);
      loadReviewPanel(regionId);
    });
  });
});

function loadReviewPanel(regionId) {
  const container = document.querySelector('.container');

  if (!container.classList.contains('active')) {
    container.classList.add('active');
  }

  requestAnimationFrame(() => {
    loadRegionInfo(regionId);
	updateFavoriteStatus(regionId);
  });
}

function loadRegionInfo(regionId) {
  const encodedRegion = encodeURIComponent(regionId);
  console.log(`loadRegionInfo 요청: ${encodedRegion}`);

  fetch(`/region/info?region=${encodedRegion}`)
    .then(response => {
      if (!response.ok) throw new Error(`HTTP error: ${response.status}`);
      return response.json();
    })
    .then(data => {
      console.log("지역 데이터:", data);

      if (data.error) {
        alert(data.error);
        return;
      }

      document.querySelector(".region-name").textContent = data.name || "이름 없음";
      document.querySelector(".region-desc").textContent = data.description || "설명 없음";
      document.querySelector(".score").textContent = (data.avgScore || 0).toFixed(1);
      document.querySelector(".stars").textContent = "★".repeat(Math.round(data.avgScore || 0));

      const img = document.querySelector(".region-thumbnail img");
      img.src = data.thumbnailUrl || "/img/basic.jpg";
      img.alt = `${data.name || "지역"} 썸네일`;
	  
	  document.getElementById('modal-region-name').textContent = data.name || '地域'; //리뷰 작성 모달 지역 설정
	  document.getElementById('modal-region-name').dataset.regionId = data.regionId || '';

      const reviewList = document.querySelector(".review-list");
      reviewList.innerHTML = "";

      if (data.reviews && data.reviews.length > 0) {
        data.reviews.forEach(review => {
          const item = document.createElement("div");
          item.className = "review-item";

          const imageHtml = (review.imageUrls || []).map(url => `<img src="${url}" alt="리뷰이미지">`).join('');

          item.innerHTML = `
            <div class="review-header">
              <div class="user-section">
                <img src="\${review.userImageUrl || 'default-profile.jpg'}" alt="유저사진" class="user-photo">
                <div class="user-info">
                  <span class="user-name">\${review.userName || '익명'}</span>
                  <span class="review-date">\${review.date || ''}</span>
                  <div class="review-rating">
                    <span class="score">\${(review.score || 0).toFixed(1)}</span>
                    <span class="stars">\${'★'.repeat(Math.round(review.score || 0))}</span>
                  </div>
                </div>
              </div>
            </div>
            <div class="review-content">\${review.content || ''}</div>
            <div class="review-images">\${imageHtml}</div>
          `;

          reviewList.appendChild(item);
        });
      } else {
        reviewList.innerHTML = "<div class='no-reviews'>아직 리뷰가 없습니다.</div>";
      }
    })
    .catch(error => {
      console.error("지역 정보 로드 실패", error);
      alert("지역 정보를 불러오는 데 실패했습니다.");
    });
}

document.addEventListener('DOMContentLoaded', function() {
    const regions = document.querySelectorAll('.region');
    const favBtn = document.querySelector('.favorite-btn');

    const initRegionId = favBtn.getAttribute('data-region-id');
    if (initRegionId) {
        fetch(`/ikitai/check?regionId=${initRegionId}`)
            .then(res => res.json())
            .then(data => {
                favBtn.textContent = data.isAdded ? '❤️' : '🤍';
            });
    }

    regions.forEach(region => {
        region.addEventListener('click', function() {
            const regionId = region.getAttribute('data-id');
            favBtn.setAttribute('data-region-id', regionId);
			updateFavoriteStatus(regionId);

            fetch(`/ikitai/check?regionId=${regionId}`)
                .then(res => res.json())
                .then(data => {
                    favBtn.textContent = data.isAdded ? '❤️' : '🤍';
                });
        });
    });

    favBtn.addEventListener('click', function() {
        const regionId = favBtn.getAttribute('data-region-id');

        if (!regionId) {
            alert("地域を選択してください！");
            return;
        }

        fetch('/ikitai/toggle', {
            method: 'POST',
            headers: { 'Content-type': 'application/json' },
            body: JSON.stringify({ regionId: regionId }),
            credentials: 'same-origin'
        })
        .then(response => {
            if (response.ok) {
                return response.text();
            } else {
                throw new Error("登録に失敗しました。");
            }
        })
        .then(result => {
            favBtn.textContent = (result === 'added') ? '❤️' : '🤍';
        })
        .catch(error => {
            console.error(error);
            alert("エラーが発生しました。");
        });
    });
});


document.addEventListener("DOMContentLoaded", function() {
  const modal = document.getElementById('review-modal');
  const openBtn = document.querySelector('.review-write-btn button'); // + 버튼
  const closeBtn = modal.querySelector('.review-modal-close');
  const submitBtn = document.getElementById('review-submit');
  const starElements = modal.querySelectorAll('.review-stars span');
  let selectedScore = 0;

  // 모달 열기
  openBtn.addEventListener('click', function() {
    modal.style.display = 'block';
  });

  // 모달 닫기
  closeBtn.addEventListener('click', function() {
    modal.style.display = 'none';
    resetModal();
  });

  // 별점 선택
  starElements.forEach(star => {
    star.addEventListener('click', function() {
      selectedScore = parseInt(this.getAttribute('data-value'));
      updateStars(selectedScore);
    });
  });

  // 등록 버튼
  submitBtn.addEventListener('click', function() {
    const text = document.getElementById('review-text').value;
    const images = document.getElementById('review-image').files;

    if (selectedScore === 0) {
      alert('별점을 선택해주세요.');
      return;
    }
    if (!text.trim()) {
      alert('리뷰 내용을 작성해주세요.');
      return;
    }

    // 여기에 Ajax 또는 fetch로 데이터 전송 처리 가능
    console.log('등록 데이터:', { score: selectedScore, text, images });

    alert('리뷰가 등록되었습니다.');
    modal.style.display = 'none';
    resetModal();
  });

  // 별점 UI 업데이트
  function updateStars(score) {
    starElements.forEach(star => {
      const value = parseInt(star.getAttribute('data-value'));
      star.style.color = value <= score ? 'orange' : '#ccc';
    });
  }

  // 모달 초기화
  function resetModal() {
    document.getElementById('review-text').value = '';
    document.getElementById('review-image').value = '';
    selectedScore = 0;
    updateStars(0);
  }
});


function updateFavoriteStatus(regionId) {
  const favBtn = document.querySelector('.favorite-btn');
  favBtn.setAttribute('data-region-id', regionId);

  fetch(`/ikitai/check?regionId=${regionId}`)
    .then(res => res.json())
    .then(data => {
      favBtn.textContent = data.isAdded ? '❤️' : '🤍';
    })
    .catch(err => {
      console.error("하트 상태 로드 실패", err);
      favBtn.textContent = '🤍';
    });
}

