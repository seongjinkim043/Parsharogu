svg.addEventListener('wheel', function(e) {
  e.preventDefault();
  const zoomFactor = 0.1;
  let [x, y, w, h] = viewBox;

  if (e.deltaY < 0) {
    // zoom in
    w *= 1 - zoomFactor;
    h *= 1 - zoomFactor;
  } else {
    // zoom out
    w *= 1 + zoomFactor;
    h *= 1 + zoomFactor;
  }

  x = x + (viewBox[2] - w) / 2;
  y = y + (viewBox[3] - h) / 2;

  viewBox = [x, y, w, h];
  svg.setAttribute('viewBox', viewBox.join(' '));
});

document.querySelectorAll('.region').forEach(region => {
  region.addEventListener('click', () => {
    const regionId = region.dataset.id;
    console.log(`Region ${regionId} clicked`);
    // loadReview(regionId); // 추후 추가
  });
});

