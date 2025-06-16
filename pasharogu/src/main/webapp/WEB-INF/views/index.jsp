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
	
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	color: #5a3e36;
	margin: 0;
	padding: 0;
	position: relative;
	s height: 100vh;
	width: 100vw;
	overflow: hidden;
}

.fc {
  background-color: #ffffff;
  border-radius: 16px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.08);
  overflow: hidden;
  color: #222222;
  
}

/* 날짜 셀 영역 */
.fc-daygrid-day {
  background-color: #ffffff;
  transition: background 0.2s ease;
}
/* 주말 구분 */
.fc-day-sat, .fc-day-sun {
  background-color: #fafafa;
}


.fc-day-today {
  background-color: #f0f0f0 !important;
  font-weight: bold;
  border: none;
}

.calendar-wrapper {
  display: flex;
  width: 100%;
  height: 100%;
  gap: 20px;
  overflow: hidden; /* ✅ 내부 넘침 방지 */
}

#calendar1, #calendar2 {
  flex: 1;
  max-width: 48%; /* ✅ 한쪽이 너무 커지지 않게 제한 */
  height: 100%;
  box-sizing: border-box;
}

#calendarDayView {
    width: 100%;
    height: 100%;
    background: #fff;
    border-radius: 20px;
    box-shadow: 0 8px 20px rgba(255, 157, 157, 0.3);
    padding: 20px;	
    box-sizing: border-box;
}

.calendar {
  width: 100%;
  height: 500px;
  overflow: hidden; /* ✅ 안에서 캘린더가 튀어나가지 않도록 */
  box-sizing: border-box;
  padding: 10px;
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
  background-color: #222222 !important;
  color: #ffffff !important;
  border: none !important;
  border-radius: 8px !important;
  padding: 2px 6px !important;
  font-size: 0.85rem;
  box-shadow: 0 2px 6px rgba(0,0,0,0.1);
}
.fc-daygrid-day:hover {
  background-color: #f5f5f5;
  cursor: pointer;
}

/* multiDay event 색상 */
.multi-day-event {
  background-color: #444444 !important; /* 딥 그레이 */
  color: #ffffff !important;            /* 흰 글씨 */
  border-radius: 8px !important;
  font-weight: 500;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}
.calendar-controls {
	position: fixed;
	top: 60px;
	left: 100px;
}

.calendar-controls button {
  background-color: #222222;
  color: white;
  border: none;
  padding: 10px 18px;
  margin-right: 10px;
  font-weight: bold;
  border-radius: 8px;
  box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
  transition: background 0.2s ease;
}

.calendar-controls button:hover {
  background-color: #444444;
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
  background-color: #222;  /* 기본: 진한 검정 */
  color: white;
  border: none;
  padding: 10px 15px;
  margin-right: 10px;
  border-radius: 10px;
  font-weight: bold;
  cursor: pointer;
  transition: background 0.2s ease;
}

#eventModal button:hover {
  background-color: #444;
}

#deleteEventBtn {
  background-color: #888 !important; /* 회색 */
  color: white;
}

#deleteEventBtn:hover {
  background-color: #666 !important;
}

#goDayViewBtn {
  background-color: #ccc !important; /* 연한 회색 */
  color: #111;
}

#goDayViewBtn:hover {
  background-color: #aaa !important;
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
        	  const today = new Date();
        	  const todayStr = today.toISOString().slice(0, 10); // 'YYYY-MM-DD'

        	  const fontResponse = await fetch('/fonts/NanumGothic.ttf');
        	  const fontBlob = await fontResponse.blob();
        	  const fontReader = new FileReader();

        	  await new Promise((resolve) => {
        	    fontReader.onload = function () {
        	      const fontData = fontReader.result.split(',')[1];
        	      window.jspdf.jsPDF.API.events.push(["addFonts", function () {
        	        this.addFileToVFS("NanumGothic.ttf", fontData);
        	        this.addFont("NanumGothic.ttf", "NanumGothic", "normal");
        	      }]);
        	      resolve();
        	    };
        	    fontReader.readAsDataURL(fontBlob);
        	  });

        	  const view = calendar1.view;
        	  const startDate = new Date(view.currentStart);
        	  const year = startDate.getFullYear();
        	  const month = startDate.getMonth();
        	  const ym = year + '-' + ((month + 1).toString().padStart(2, '0'));

        	  const response = await fetch('/scheduleList.do?yearMonth=' + ym);
        	  const events = await response.json();

        	  const firstDay = new Date(year, month, 1);
        	  const startDay = firstDay.getDay();
        	  const daysInMonth = new Date(year, month + 1, 0).getDate();

        	  const calendarData = Array.from({ length: 6 }, () => Array(7).fill(""));
        	  const cellMeta = Array.from({ length: 6 }, () => Array(7).fill(null));

        	  let day = 1, row = 0, col = startDay;

        	  while (day <= daysInMonth) {
        	    const mm = (month + 1).toString().padStart(2, '0');
        	    const dd = day.toString().padStart(2, '0');
        	    const dayStr = year + '-' + mm + '-' + dd;

        	    const dayEvents = events.filter(e => {
        	      const start = new Date(e.start);
        	      const end = e.end ? new Date(e.end) : new Date(e.start);
        	      end.setSeconds(end.getSeconds() - 1);
        	      const eventRange = [];
        	      let current = new Date(start);
        	      while (current <= end) {
        	        eventRange.push(current.toISOString().slice(0, 10));
        	        current.setDate(current.getDate() + 1);
        	      }
        	      return eventRange.includes(dayStr);
        	    });

        	    dayEvents.sort((a, b) => new Date(a.start) - new Date(b.start));

        	    let multiLine = [];
        	    let singleLine = [];

        	    for (const e of dayEvents) {
        	      if (e.multiDayFlag) {
        	        multiLine.push((e.title || ''));
        	      } else {
        	        const time = new Date(e.start).toLocaleTimeString('ko-KR', {
        	          hour: '2-digit',
        	          minute: '2-digit',
        	          hour12: false
        	        });
        	        singleLine.push('• ' + time + ' ' + (e.title || ''));
        	      }
        	    }

        	    let cellText = day.toString();
        	    if (dayStr === todayStr) {
        	      cellText = '⭐ ' + cellText;
        	    }

        	    let fullText = cellText;
        	    if (multiLine.length > 0) {
        	      fullText += '\n' + multiLine.join('\n');
        	    }
        	    if (singleLine.length > 0) {
        	      fullText += '\n' + singleLine.join('\n');
        	    }

        	    calendarData[row][col] = fullText;

        	    cellMeta[row][col] = {
        	      isMulti: multiLine.length > 0
        	    };

        	    col++;
        	    if (col > 6) {
        	      col = 0;
        	      row++;
        	    }
        	    day++;
        	  }

        	  const { jsPDF } = window.jspdf;
        	  const doc = new jsPDF('landscape');

        	  doc.autoTable({
        	    startY: 30,
        	    head: [["일", "월", "화", "수", "목", "금", "토"]],
        	    body: calendarData,
        	    theme: 'grid',
        	    styles: {
        	      font: "NanumGothic",
        	      fontSize: 10,
        	      minCellHeight: 28,
        	      cellPadding: 4,
        	      textColor: 20
        	    },
        	    headStyles: {
        	      fillColor: [0, 0, 0],
        	      textColor: [255, 255, 255],
        	      fontStyle: 'bold'
        	    },
        	    alternateRowStyles: {
        	      fillColor: [255, 255, 255]
        	    },
        	    didParseCell: function (data) {
        	      const { row, column } = data;
        	      if (data.section === 'body') {
        	        const r = row.index, c = column.index;
        	        if (cellMeta[r] && cellMeta[r][c]?.isMulti) {
        	          data.cell.styles.textColor = [30, 70, 200]; // 파란색
        	          data.cell.styles.fontStyle = 'bolditalic';
        	        }
        	      }
        	    }
        	  });

        	  doc.save(year + '-' + (month + 1) + '_달력일정.pdf');
        	});


      });
  </script>
</body>
</html>

