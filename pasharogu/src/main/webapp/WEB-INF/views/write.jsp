<%@ page contentType="text/html;charset=UTF-8" %>
<form action="/review/write" method="post">
    <input type="hidden" name="regionId" value="${regionId}">
    
    <label>별점:</label>
    <select name="rating">
        <c:forEach var="i" begin="1" end="5">
            <option value="${i}">${i}</option>
        </c:forEach>
    </select>

    <label>내용:</label>
    <textarea name="content" rows="5" cols="50"></textarea>

    <button type="submit">작성 완료</button>
</form>
