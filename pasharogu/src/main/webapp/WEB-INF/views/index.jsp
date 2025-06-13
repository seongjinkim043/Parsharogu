<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    #calendar {
       position: fixed;
  top: 200px;
  left: 100px;
  width: 40vw;
  height: 40vh;
  background: #fff;
  border-radius: 20px;
  box-shadow: 0 8px 20px rgba(255, 157, 157, 0.3);
  padding: 20px;
  z-index: 9999;
    }
    .fc-header-toolbar {
      margin-bottom: 15px;
    }
    .fc-button {
      background: #ff9f9f !important;
      border: none !important;
      color: white !important;
      font-weight: 700;
      border-radius: 10px !important;
      box-shadow: 0 4px 10px rgba(255, 159, 159, 0.4);
      transition: background-color 0.3s ease;
    }
    .fc-button:hover, .fc-button:focus {
      background: #ff6f6f !important;
      box-shadow: 0 6px 14px rgba(255, 111, 111, 0.6);
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
    #eventModal {
      display: none;
      position: fixed;
      top: 0; left: 0; width: 100%; height: 100%;
      backdrop-filter: blur(4px);
      align-items: center;
      justify-content: center;
      z-index: 9999;
      animation: fadeIn 0.3s ease forwards;
    }
    #eventModal .modal-content {
      background: #ffffff;
      border-radius: 20px;
      padding: 30px 35px;
      width: 350px;
      box-shadow: 0 4px 8px rgba(245, 222, 179, 1);
      position: relative;
      font-weight: 600;
      color: #80334d;
      font-size: 1rem;
      animation: slideUp 0.4s ease forwards;
    }
    #eventModal label {
      display: block;
      margin-top: 15px;
      font-weight: 700;
      color: #a64d79;
      font-size: 0.9rem;
    }
    #eventModal input {
      width: 100%;
      padding: 10px 12px;
      margin-top: 6px;
      border-radius: 12px;
      border: 2px solid #f4c2c2;
      font-size: 1rem;
      font-weight: 500;
      color: #6b3a56;
      outline: none;
      transition: border-color 0.3s ease;
    }
    #eventModal input:focus {
      border-color: #ff6f91;
      box-shadow: 0 0 6px #ff6f91;
    }
    #eventModal .btn-group {
      margin-top: 25px;
      text-align: right;
    }
    #saveEventBtn {
      background-color: #ff69b4;
      border: none;
      padding: 10px 22px;
      border-radius: 15px;
      font-weight: 700;
      color: white;
      cursor: pointer;
      box-shadow: 0 5px 15px rgba(255, 105, 180, 0.5);
      transition: background-color 0.3s ease;
    }
    #saveEventBtn:hover {
      background-color: #d5387a;
      box-shadow: 0 8px 22px rgba(213, 56, 122, 0.8);
    }
    #closeModalBtn {
      background-color: #fcd1e5;
      border: none;
      padding: 10px 22px;
      border-radius: 15px;
      font-weight: 700;
      color: #a6446a;
      margin-left: 12px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }
    #closeModalBtn:hover {
      background-color: #f9a7c1;
    }
    @keyframes fadeIn {
      from {opacity: 0;}
      to {opacity: 1;}
    }
    @keyframes slideUp {
      from {transform: translateY(40px); opacity: 0;}
      to {transform: translateY(0); opacity: 1;}
    }
  </style>
</head>
<body>

  <div id='calendar'></div>

  <!-- 일정 추가용 모달 -->
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
      var calendarEl = document.getElementById('calendar');

      var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
      
        selectable: true,
        selectMirror: true,
        dayMaxEvents: true,
        events: '/scheduleList.do',
        select: function(info) {
          $('#eventModal').css('display', 'flex');
          $('#eventStart').val(info.startStr);
          $('#eventEnd').val(info.endStr ? info.endStr : info.startStr);
          $('#eventTitle').val('');
        },
        eventClick: function(info) {
          if(confirm(`'${info.event.title}' 일정을 삭제하시겠습니까?`)) {
            $.ajax({
              url: '/scheduleDelete.do',
              type: 'POST',
              contentType: 'application/json',
              data: JSON.stringify({ id: info.event.id }),
              success: function() {
                info.event.remove();
                alert('일정이 삭제되었습니다.');
              },
              error: function() {
                alert('일정 삭제 중 오류가 발생했습니다.');
              }
            });
          }
        }
      });

      calendar.render();

      $('#closeModalBtn').click(function() {
        $('#eventModal').hide();
      });

      $('#saveEventBtn').click(function() {
        var title = $('#eventTitle').val().trim();
        var start = $('#eventStart').val();
        var end = $('#eventEnd').val();

        if (!title) {
          alert('일정 제목을 입력해주세요!');
          return;
        }
        if (!start) {
          alert('시작일을 선택해주세요!');
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
          data: JSON.stringify({
            title: title,
            start: start,
            end: end
          }),
          success: function(newEvent) {
            calendar.addEvent(newEvent);
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
