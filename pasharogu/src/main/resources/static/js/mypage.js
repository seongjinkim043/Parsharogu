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
	            }, 500);
	        }
	    });
	}
	function handleClick() {
	    alert('マイプロフィールに移動しますか？');
	  }