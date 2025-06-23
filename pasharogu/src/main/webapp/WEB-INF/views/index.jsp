<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8" />
<link rel="stylesheet" href="/css/calender.css">
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

<script >window.addEventListener('load', function() {
    document.documentElement.style.minHeight = '1500px';
    document.body.style.minHeight = '1500px';
});
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Fredoka:wght@600&display=swap');
html {
    overflow-y: scroll !important;  /* ✅ 이거 1줄이면 끝 */
}
</style>

</head>
<body>

<div id="calendarDayViewWrapper" style="display: none;">

  <div id="calendarDayView"></div>
</div>

<div class="calendar-wrapper">
  <!-- 첫 번째 달력 + 왼쪽 화살표 -->
  <div class="calendar-box">
    <button id="prevBtn" class="arrow-btn calendar-arrow-left">&#8592;</button>
    <div id="calendar1"></div>
  </div>

  <!-- 두 번째 달력 + 오른쪽 화살표 -->
  <div class="calendar-box">
    <button id="nextBtn" class="arrow-btn calendar-arrow-right">&#8594;</button>
    <div id="calendar2"></div>
  </div>

  <!-- 데이뷰는 별도로 처리 -->
 </div>


	<!-- 모달: 일정 추가/수정 -->
	<div id="eventModal">
		<div class="modal-content">
		
			<h2 style="margin-top: 0; text-align: center;">予定の追加・編集</h2>
			<label for="eventTitle">タイトル</label> <input type="text" id="eventTitle"
				placeholder="タイトルを入力してください" /> <label for="eventStart">開始日時</label> <input
				type="datetime-local" id="eventStart" /> <label for="eventEnd">開始日時</label>
			<input type="datetime-local" id="eventEnd" />

			<div class="btn-group">
				<button id="saveEventBtn" style="background-color:  #3b4c68;">保存</button>
    <button id="deleteEventBtn" style="background-color:  #3b4c68;">削除</button>
    <button id="goDayViewBtn" style="background-color: #a3d8ff;">Day View</button>
    <button id="closeModalBtn" style="background-color: #7aa0c4;font-size: 0.85rem; white-space: nowrap;">キャンセル</button>
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
        height: '100%',
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
        },
        eventDidMount: function(info) {
        	  info.el.setAttribute('title', 
        	    '제목: ' + info.event.title + 
        	    '\n시작: ' + info.event.start.toLocaleString() + 
        	    (info.event.end ? '\n종료: ' + info.event.end.toLocaleString() : '')
        	  );
        	}

       
      });

      const calendar2 = new FullCalendar.Calendar(calendarEl2, {
        initialView: 'dayGridMonth',
        height: '100%',
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

      const calendarDayView = new FullCalendar.Calendar(document.getElementById('calendarDayView'), {
    	    initialView: 'timeGridDay',
    	    initialDate: today,
    	    headerToolbar: { left: '', center: 'title', right: '' },
    	    slotMinTime: "06:00:00",
    	    slotMaxTime: "26:00:00",
    	    slotDuration: "00:30:00",
    	    selectable: true,
    	    editable: true,  // ⭐ 리사이즈 가능 + 드래그 가능 추가!
    	    eventResize: function(info) {  // ⭐ 리사이즈할 때 실행되는 코드
    	        console.log('새 종료시간:', info.event.end.toISOString());
    	        $.ajax({
    	            url: '/scheduleUpdate.do',
    	            type: 'POST',
    	            contentType: 'application/json',
    	            data: JSON.stringify({
    	                id: info.event.id,
    	                start: info.event.start.toISOString(),
    	                end: info.event.end ? info.event.end.toISOString() : null,
    	                title: info.event.title  // ⭐ 여기 추가!
    	            }),
    	            success: function() {
    	            	 calendar1.refetchEvents();      // ⭐ 추가
    	            	    calendar2.refetchEvents();      // ⭐ 추가
    	                calendarDayView.refetchEvents();
    	            }
    	        });
    	    },
    	    dateClick: openModalForDateClick,
    	    allDaySlot: false,   // ★★★ all-day 칸 없애기
    	    select: openModalForRangeSelect,
    	    events: function(fetchInfo, successCallback, failureCallback) {
    	        $.ajax({
    	            url: '/scheduleList.do',
    	            type: 'GET',
    	            success: function(events) {
    	                const currentDay = fetchInfo.startStr.slice(0,10);
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

    	calendarDayView.render();
    	$('#calendarDayViewWrapper').hide();

    	$('#goDayViewBtn').click(function() {
    	    const dayDate = $('#eventStart').val().slice(0,10);
    	    $('#calendar1').hide();
    	    $('#calendar2').hide();
    	    $('#calendarDayViewWrapper').show();
    	    $('#backToMonthBtn').show();
    	    calendarDayView.changeView('timeGridDay', dayDate);
    	    $('#eventModal').hide();
    	    
    	    setTimeout(() => {
    	        if ($('#calendarDayViewWrapper .fc-toolbar').length > 0) {
    	            if ($('#calendarDayViewWrapper .fc-toolbar .back-to-month-btn').length === 0) {
    	                $('#calendarDayViewWrapper .fc-toolbar').append(`
    	                    <button class="back-to-month-btn" style="
    	                        margin-left: 10px;
    	                        background-color: #4c6fa5;
    	                        color: white;
    	                        border: none;
    	                        padding: 6px 12px;
    	                        border-radius: 8px;
    	                        font-weight: bold;
    	                        cursor: pointer;
    	                        font-size: 0.9rem;
    	                    ">←</button>
    	                `);

    	                $('.back-to-month-btn').click(function() {
    	                    $('#calendar1').show();
    	                    $('#calendar2').show();
    	                    $('#calendarDayViewWrapper').hide();
    	                });
    	            }
    	        }
    	    }, 100); // 살짝 delay
    	    
    	    
    	});

    	$('#backToMonthBtn').click(function() {
    	    $('#calendar1').show();
    	    $('#calendar2').show();
    	    $('#calendarDayViewWrapper').hide();
    	    $('#backToMonthBtn').hide();
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
            alert('タイトルと開始日時を入力してください');
            return;
          }
          if (end && end < start) {
            alert('終了日時は開始日時以降に設定してください');
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
          if (confirm('本当に削除しますか？')) {
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


