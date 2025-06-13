<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>Phasya LOG</title>

  <!-- FullCalendar CSS -->
  <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet" />

  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <!-- FullCalendar JS -->
  <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>

  <style>
    body {
      background: #fff8f0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      color: #5a3e36;
      margin: 0; padding: 0;
      position: relative;
      height: 100vh;
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
      width: 40vw;
      height: 40vh;
      background: #fff;
      border-radius: 20px;
      box-shadow: 0 8px 20px rgba(255, 157, 157, 0.3);
      padding: 20px;
    }

    .fc-header-toolbar {
      margin-bottom: 15px;
    }

    .fc-toolbar-chunk:first-child,
    .fc-toolbar-chunk:last-child {
      display: none !important; /* 기본 이전/다음/today 버튼 숨김 */
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
    .fc-event:hover {
      transform: scale(1.07);
      box-shadow: 0 8px 12px rgba(255, 182, 185, 0.9);
    }
    .fc-daygrid-day:hover {
      background-color: #ffe5e5;
      cursor: pointer;
      border-radius: 15px;
      transition: background-color 0.3s ease;
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
      top: 0; left: 0; right: 0; bottom: 0;
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
    #eventModal input[type="text"],
    #eventModal input[type="date"] {
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
  </style>
</head>
<body>

  <!-- 사용자 정의 이전/다음 버튼 -->
  <div class="calendar-controls">
    <button id="prevBtn">← 이전 달</button>
    <button id="nextBtn">다음 달 →</button>
  </div>

  <div class="calendar-wrapper">
    <div id='calendar1'></div>
    <div id='calendar2'></div>
  </div>

  <!-- 모달: 일정 추가 -->
  <div id="eventModal">
    <div class="modal-content">
      <h2 style="margin-top:0; text-align:center;">새 일정 추가</h2>
      <label for="eventTitle">제목</label>
      <input type="text" id="eventTitle" placeholder="일정 제목 입력" />
      <label for="eventStart">시작일</label>
      <input type="date" id="eventStart" />
      <label for="eventEnd">종료일</label>
      <input type="date" id="eventEnd" />
      <div class="btn-group">
        <button id="saveEventBtn">저장</button>
        <button id="closeModalBtn">취소</button>
      </div>
    </div>
  </div>

  <script>
    document.addEventListener('DOMContentLoaded', function() {
      const calendarEl1 = document.getElementById('calendar1');
      const calendarEl2 = document.getElementById('calendar2');
      const today = new Date();

      const calendar1 = new FullCalendar.Calendar(calendarEl1, {
        initialView: 'dayGridMonth',
        initialDate: today,
        events: '/scheduleList.do',
        headerToolbar: {
          left: '',
          center: 'title',
          right: ''
        },
        dateClick: function(info) {
          $('#eventModal').css('display', 'flex');
          $('#eventStart').val(info.dateStr);
          $('#eventEnd').val(info.dateStr);
          $('#eventTitle').val('');
        },
        eventClick: function(info) {
          if (confirm(`'${info.event.title}' 일정을 삭제하시겠습니까?`)) {
            $.ajax({
              url: '/scheduleDelete.do',
              type: 'POST',
              contentType: 'application/json',
              data: JSON.stringify({ id: info.event.id }),
              success: function () {
                info.event.remove();
                alert('일정이 삭제되었습니다.');
              },
              error: function () {
                alert('일정 삭제 중 오류가 발생했습니다.');
              }
            });
          }
        }
      });

      const calendar2 = new FullCalendar.Calendar(calendarEl2, {
        initialView: 'dayGridMonth',
        initialDate: new Date(today.getFullYear(), today.getMonth() + 1, 1),
        headerToolbar: {
          left: '',
          center: 'title',
          right: ''
        },
        selectable: false
      });

      calendar1.render();
      calendar2.render();

      $('#nextBtn').click(function() {
        calendar1.next();
        calendar2.next();
      });

      $('#prevBtn').click(function() {
        calendar1.prev();
        calendar2.prev();
      });

      $('#closeModalBtn').click(function() {
        $('#eventModal').hide();
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

        $.ajax({
          url: '/scheduleAdd.do',
          type: 'POST',
          contentType: 'application/json',
          data: JSON.stringify({ title, start, end }),
          success: function(newEvent) {
            calendar1.addEvent(newEvent);
            $('#eventModal').hide();
          },
          error: function() {
            alert('일정 추가 중 오류가 발생했어요.');
          }
        });
      });
    });
  </script>
</body>
</html>
