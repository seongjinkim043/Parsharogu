<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>리뷰 지도 서비스</title>
    <style>
        body { margin: 0; font-family: 'Noto Sans KR', sans-serif; }

        .container {
            display: flex;
            height: 100vh;
        }

        .left-box {
            width: 50%;
            padding: 80px;
        }

        .left-box h1 {
            font-size: 28px;
            margin-bottom: 20px;
        }

        .left-box p {
            color: #666;
            line-height: 1.6;
        }

        .left-box button {
            margin-top: 30px;
            padding: 12px 24px;
            background-color: red;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .right-map {
            width: 50%;
            position: relative;
            background: url("/images/japan-map.png") no-repeat center;
            background-size: contain;
        }

        .region-btn {
            position: absolute;
            background: rgba(255, 255, 255, 0.8);
            padding: 8px 16px;
            border-radius: 4px;
            font-weight: bold;
            cursor: pointer;
        }

        .region1 { top: 20%; left: 60%; }  /* 삿포로 */
        .region2 { top: 40%; left: 50%; }  /* 도쿄 */
        .region3 { top: 70%; left: 55%; }  /* 오사카 */
    </style>
</head>
<body>

<div class="container">
    <div class="left-box">
        <h1>지역마다 감상을 나누는<br>리뷰 지도 서비스</h1>
        <p>사용자들이 일본 각 지역에 남긴 후기를 지도 위에서 쉽게 보고<br>공감하며 공유할 수 있습니다.</p>
        <form action="/region" method="get">
            <button type="submit">지역별로 보기</button>
        </form>
    </div>

    <div class="right-map">
        <div class="region-btn region1">삿포로</div>
        <div class="region-btn region2">도쿄</div>
        <div class="region-btn region3">오사카</div>
    </div>
</div>

</body>
</html>
