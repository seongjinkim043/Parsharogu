<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>Phasya LOG</title>

<!-- FullCalendar CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css"
	rel="stylesheet" />

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- FullCalendar JS -->
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
<!-- jsPDF & AutoTable -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.28/jspdf.plugin.autotable.min.js"></script>
<!-- NanumGothic Font 등록 -->


<style>
body {
	background: #fff8f0;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	color: #5a3e36;
	margin: 0;
	padding: 0;
	position: relative;
	s height: 100vh;
	width: 100vw;
	overflow: hidden;
}

.calendar-wrapper {
	position: fixed;
	top: 120px;
	left: 80px;
	display: flex;
	gap: 30px;
}

#calendar1, #calendar2 {
	width: 20vw;
	height: 40vh;
	background: #fff;
	border-radius: 20px;
	box-shadow: 0 8px 20px rgba(255, 157, 157, 0.3);
	padding: 20px;
}

#calendarDayView {
	width: 80vw;
	height: 80vh;
	background: #fff;
	border-radius: 20px;
	box-shadow: 0 8px 20px rgba(255, 157, 157, 0.3);
	padding: 20px;
}

.fc-header-toolbar {
	margin-bottom: 15px;
}

.fc-toolbar-chunk:first-child, .fc-toolbar-chunk:last-child {
	display: none !important;
}

.fc-toolbar-title {
	font-size: 1.5rem;
	font-weight: bold;
}

.fc-event {
	background: #ffb6b9 !important;
	border: none !important;
	border-radius: 12px !important;
	box-shadow: 0 4px 6px rgba(255, 182, 185, 0.6);
	font-weight: 600;
	color: #611d1d !important;
	cursor: pointer;
	padding-left: 8px !important;
	padding-right: 8px !important;
	transition: transform 0.2s ease;
}

/* multiDay event 색상 */
.multi-day-event {
	background: #cdb4db !important;
	color: #3d1f40 !important;
}

.calendar-controls {
	position: fixed;
	top: 60px;
	left: 100px;
}

.calendar-controls button {
	background-color: #ffa3b1;
	border: none;
	padding: 10px 18px;
	margin-right: 10px;
	font-weight: bold;
	color: white;
	border-radius: 12px;
	box-shadow: 0 4px 10px rgba(255, 133, 157, 0.4);
	cursor: pointer;
}

.calendar-controls button:hover {
	background-color: #ff6f91;
}

#eventModal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0.5);
	align-items: center;
	justify-content: center;
	z-index: 9999;
}

#eventModal .modal-content {
	background: white;
	padding: 30px;
	border-radius: 20px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
	max-width: 400px;
	width: 90%;
}

#eventModal input[type="text"], #eventModal input[type="datetime-local"]
	{
	width: 100%;
	margin-bottom: 15px;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 10px;
}

#eventModal button {
	background-color: #ff6f91;
	border: none;
	padding: 10px 15px;
	margin-right: 10px;
	color: white;
	border-radius: 10px;
	font-weight: bold;
	cursor: pointer;
}

#eventModal button:hover {
	background-color: #ff3f6d;
}

.btn-group {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	margin-top: 10px;
	gap: 10px;
}
</style>
</head>
<body>

	<!-- 사용자 정의 이전/다음 버튼 -->
	<div class="calendar-controls">
		<button id="prevBtn">← 이전 달</button>
		<button id="nextBtn">다음 달 →</button>
		<button id="backToMonthBtn" style="display: none;">월로 돌아가기</button>

		<button id="downloadPdfCalendarBtn">📄 PDF 다운로드</button>


	</div>

	<div class="calendar-wrapper">
		<div id='calendar1'></div>
		<div id='calendar2'></div>
		<div id='calendarDayView' style="display: none;"></div>
	</div>


	<!-- 메모 박스 -->
	<div style="position: fixed; bottom: 20px; left: 80px; right: 80px;">
		<label for="memoBox"
			style="font-weight: bold; display: block; margin-bottom: 5px;">한
			거 / 해야할 거</label>
		<textarea id="memoBox" rows="3"
			style="width: 100%; padding: 10px; border-radius: 10px; border: 1px solid #ccc; box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1); font-size: 1rem; font-family: inherit; resize: vertical;"
			placeholder="지금 되는 거 : 클릭해서 일정 추가/수정/삭제 / Day View 보기 가능"></textarea>
	</div>

	<!-- 모달: 일정 추가/수정 -->
	<div id="eventModal">
		<div class="modal-content">
			<h2 style="margin-top: 0; text-align: center;">일정 추가/수정</h2>
			<label for="eventTitle">제목</label> <input type="text" id="eventTitle"
				placeholder="일정 제목 입력" /> <label for="eventStart">시작일시</label> <input
				type="datetime-local" id="eventStart" /> <label for="eventEnd">종료일시</label>
			<input type="datetime-local" id="eventEnd" />

			<div class="btn-group">
				<button id="saveEventBtn">저장</button>
				<button id="deleteEventBtn" style="background-color: #bbb;">삭제</button>
				<button id="goDayViewBtn" style="background-color: #a1cfff;">Day
					View 보기</button>
				<button id="closeModalBtn">취소</button>
			</div>
		</div>
	</div>

	<script>
    document.addEventListener('DOMContentLoaded', function() {
    	
      const calendarEl1 = document.getElementById('calendar1');
      const calendarEl2 = document.getElementById('calendar2');
      const calendarDayEl = document.getElementById('calendarDayView');
      const today = new Date();

      let selectedEventId = null;
      let selectedMultiDayFlag = false;

      const calendar1 = new FullCalendar.Calendar(calendarEl1, {
        initialView: 'dayGridMonth',
        initialDate: today,
        headerToolbar: { left: '', center: 'title', right: '' },
        selectable: true,
        dateClick: openModalForDateClick,
        select: openModalForRangeSelect,
        events: {
          url: '/scheduleList.do',
          extraParams: function() {
            return {};
          }
        },
        eventClick: openModalForExistingEvent,
        eventClassNames: function(arg) {
          // multiDayFlag가 true인 경우 custom className 적용
          if (arg.event.extendedProps.multiDayFlag) {
            return ['multi-day-event'];
          }
          return [];
        }
      });

      const calendar2 = new FullCalendar.Calendar(calendarEl2, {
        initialView: 'dayGridMonth',
        initialDate: new Date(today.getFullYear(), today.getMonth() + 1, 1),
        headerToolbar: { left: '', center: 'title', right: '' },
        selectable: true,
        dateClick: openModalForDateClick,
        select: openModalForRangeSelect,
        events: '/scheduleList.do',
        eventClick: openModalForExistingEvent,
        eventClassNames: function(arg) {
          if (arg.event.extendedProps.multiDayFlag) {
            return ['multi-day-event'];
          }
          return [];
        }
      });

      const calendarDayView = new FullCalendar.Calendar(calendarDayEl, {
    	  initialView: 'timeGridDay',
    	  initialDate: today,
    	  headerToolbar: { left: '', center: 'title', right: '' },
    	  slotMinTime: "06:00:00",
    	  slotMaxTime: "22:00:00",
    	  slotDuration: "00:30:00",
    	  selectable: true,
    	  dateClick: openModalForDateClick,
    	  select: openModalForRangeSelect,
    	  events: function(fetchInfo, successCallback, failureCallback) {
    	    $.ajax({
    	      url: '/scheduleList.do',
    	      type: 'GET',
    	      success: function(events) {
    	        const currentDay = fetchInfo.startStr.slice(0,10); // yyyy-mm-dd

    	        const filteredEvents = events.filter(event => {
    	          const eventStartDate = event.start.slice(0,10);
    	          return !event.multiDayFlag && eventStartDate === currentDay;
    	        });

    	        successCallback(filteredEvents);
    	      },
    	      error: function() {
    	        failureCallback();
    	      }
    	    });
    	  },
    	  eventClick: openModalForExistingEvent
    	});

      calendar1.render();
      calendar2.render();
      calendarDayView.render();
      $('#calendarDayView').hide();

      $('#nextBtn').click(function() {
          calendar1.next();
          calendar2.next();
        });

        $('#prevBtn').click(function() {
          calendar1.prev();
          calendar2.prev();
        });

        $('#backToMonthBtn').click(function() {
          $('#calendar1').show();
          $('#calendar2').show();
          $('#calendarDayView').hide();
          $('#backToMonthBtn').hide();
        });

        $('#closeModalBtn').click(function() {
          $('#eventModal').hide();
          selectedEventId = null;
          selectedMultiDayFlag = false;
        });

        $('#saveEventBtn').click(function() {
          const title = $('#eventTitle').val().trim();
          const start = $('#eventStart').val();
          const end = $('#eventEnd').val();

          if (!title || !start) {
            alert('제목과 시작일은 필수입니다!');
            return;
          }
          if (end && end < start) {
            alert('종료일은 시작일 이후여야 해요!');
            return;
          }

          const url = selectedEventId ? '/scheduleUpdate.do' : '/scheduleAdd.do';
          const payload = {
            title, start, end,
            multiDayFlag: selectedMultiDayFlag
          };
          if (selectedEventId) {
            payload.id = selectedEventId;
          }

          $.ajax({
            url: url,
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(payload),
            success: function() {
              calendar1.refetchEvents();
              calendar2.refetchEvents();
              calendarDayView.refetchEvents();
              $('#eventModal').hide();
              selectedEventId = null;
              selectedMultiDayFlag = false;
            }
          });
        });

        $('#deleteEventBtn').click(function() {
          if (!selectedEventId) return;
          if (confirm('정말 삭제하시겠습니까?')) {
            $.ajax({
              url: '/scheduleDelete.do',
              type: 'POST',
              contentType: 'application/json',
              data: JSON.stringify({ id: selectedEventId }),
              success: function() {
                calendar1.refetchEvents();
                calendar2.refetchEvents();
                calendarDayView.refetchEvents();
                $('#eventModal').hide();
                selectedEventId = null;
                selectedMultiDayFlag = false;
              }
            });
          }
        });

        $('#goDayViewBtn').click(function() {
          const dayDate = $('#eventStart').val().slice(0,10);
          $('#calendar1').hide();
          $('#calendar2').hide();
          $('#calendarDayView').show();
          $('#backToMonthBtn').show();
          calendarDayView.changeView('timeGridDay', dayDate);
          $('#eventModal').hide();
        });

        function openModalForDateClick(info) {
          selectedEventId = null;
          selectedMultiDayFlag = false;
          $('#eventModal').css('display', 'flex');
          $('#eventStart').val(info.dateStr + "T00:00");
          $('#eventEnd').val(info.dateStr + "T01:00");
          $('#eventTitle').val('');
          $('#goDayViewBtn').show(); // 1일짜리 클릭 → DayView 가능
        }

        function openModalForRangeSelect(info) {
            selectedEventId = null;
            $('#eventModal').css('display', 'flex');

            const startStr = info.startStr.length === 10 ? info.startStr + "T00:00" : info.startStr;
            const endStr = info.endStr.length === 10 ? info.endStr + "T00:00" : info.endStr;

            $('#eventStart').val(startStr);
            $('#eventEnd').val(endStr);
            $('#eventTitle').val('');

            const startDate = new Date(startStr);
            let endDate = new Date(endStr);

            // FullCalendar end는 exclusive → 1초 빼주기
            endDate.setSeconds(endDate.getSeconds() - 1);

            selectedMultiDayFlag = startDate.toDateString() !== endDate.toDateString();

            if (selectedMultiDayFlag) {
                $('#goDayViewBtn').hide(); // multiDay → DayView 숨김
            } else {
                $('#goDayViewBtn').show(); // 1일짜리 → DayView 가능
            }
        }

        function openModalForExistingEvent(info) {
          selectedEventId = info.event.id;
          $('#eventTitle').val(info.event.title);
          $('#eventStart').val(info.event.startStr);
          $('#eventEnd').val(info.event.end ? info.event.endStr : info.event.startStr);
          $('#eventModal').css('display', 'flex');

          // multiDayFlag 정보 읽기
          selectedMultiDayFlag = info.event.extendedProps.multiDayFlag;

          if (selectedMultiDayFlag) {
            $('#goDayViewBtn').hide(); // multiDay → DayView 숨김
          } else {
            $('#goDayViewBtn').show(); // 1일짜리 → DayView 가능
          }
        }

        document.getElementById("downloadPdfCalendarBtn").addEventListener("click", async function () {
        	const fontResponse = await fetch('/fonts/NanumGothic.ttf');
        	const fontBlob = await fontResponse.blob();
        	const fontReader = new FileReader();

        	await new Promise((resolve) => {
        	  fontReader.onload = function () {
        	    const fontData = fontReader.result.split(',')[1]; // base64 부분만 추출
        	    window.jspdf.jsPDF.API.events.push(["addFonts", function () {
        	      this.addFileToVFS("NanumGothic.ttf", fontData);
        	      this.addFont("NanumGothic.ttf", "NanumGothic", "normal");
        	    }]);
        	    resolve();
        	  };
        	  fontReader.readAsDataURL(fontBlob);
        	});
        	function formatTime(dateStr) {
        		  const d = new Date(dateStr);
        		  if (isNaN(d)) return '';
        		  const hour = d.getHours().toString().padStart(2, '0');
        		  const min = d.getMinutes().toString().padStart(2, '0');
        		  return `${hour}:${min}`;
        		}

        	const view = calendar1.view;
        	  const startDate = new Date(view.currentStart);
        	  const year = startDate.getFullYear();
        	  const month = startDate.getMonth();
        	  const ym = year + '-' + (month + 1 < 10 ? '0' + (month + 1) : (month + 1));

        	  const response = await fetch('/scheduleList.do?yearMonth=' + ym);
        	  const events = await response.json();

        	  const firstDay = new Date(year, month, 1);
        	  const startDay = firstDay.getDay();
        	  const daysInMonth = new Date(year, month + 1, 0).getDate();

        	  const calendarData = Array.from({ length: 6 }, () => Array(7).fill(""));
        	  let day = 1, row = 0, col = startDay;

        	  while (day <= daysInMonth) {
        		  // 날짜 문자열 생성 (예: 2025-06-17)
        		  const dayStr = year + '-' +
        		    ((month + 1).toString().length < 2 ? '0' + (month + 1) : (month + 1)) + '-' +
        		    (day.toString().length < 2 ? '0' + day : day);

        		  // 해당 날짜에 해당하는 일정 필터링
const dayEvents = events.filter(e => {
  const eventDate = new Date(e.start);
  if (isNaN(eventDate)) return false;

  const y = eventDate.getFullYear();
  const m = (eventDate.getMonth() + 1).toString().padStart(2, '0');
  const d = eventDate.getDate().toString().padStart(2, '0');
  const formatted = `${y}-${m}-${d}`;
  return formatted === dayStr; // dayStr는 현재 루프의 날짜
});
        		  // 시간순으로 정렬
        		  dayEvents.sort((a, b) => new Date(a.start) - new Date(b.start));

        		  // "• HH:mm 제목" 형식으로 출력 문자열 생성
 const titles = dayEvents.map(e => {
  const time = new Date(e.start).toLocaleTimeString('ko-KR', {
    hour: '2-digit',
    minute: '2-digit',
    hour12: false
  });

  return `• ${time} ${e.title || ''}`;
}).join("\n");
        		  // 셀에 날짜와 일정 텍스트 삽입
        		  calendarData[row][col] = day + (titles ? "\n" + titles : "");

        		  // 다음 셀로 이동
        		  col++;
        		  if (col > 6) {
        		    col = 0;
        		    row++;
        		  }
        		  day++;
        		}


        	  const { jsPDF } = window.jspdf;
        	  const doc = new jsPDF('landscape');
        	  
        	  doc.setFont("NanumGothic");
        	  doc.setFontSize(18);
        	  doc.text(year + "년 " + (month + 1) + "월 일정 달력", 14, 20);

        	  doc.autoTable({
        	    startY: 30,
        	    head: [["일", "월", "화", "수", "목", "금", "토"]],
        	    body: calendarData,
        	    theme: 'grid',
        	    styles: {
        	    	 font: "NanumGothic",
        	      fontSize: 10,
        	      minCellHeight: 28,
        	      cellPadding: 4
        	    },
        	    headStyles: {
        	      fillColor: [255, 140, 170],
        	      textColor: 255,
        	      fontStyle: 'bold'
        	    },
        	    alternateRowStyles: {
        	      fillColor: [255, 245, 250]
        	    }
        	  });

        	  doc.save(year + '-' + (month + 1) + '_달력일정.pdf');
        	});

      });
  </script>
</body>
</html>

