document.addEventListener("DOMContentLoaded", function () {
    // --- ID 기억하기 기능 ---
    const usernameInput = document.getElementById("username");
    const rememberCheckbox = document.getElementById("rememberId");

    // 쿠키에서 ID 불러오기
    const savedId = getCookie("rememberedId");
    if (savedId) {
        usernameInput.value = savedId;
        rememberCheckbox.checked = true;
    }

    // 로그인 폼 제출 시 쿠키 저장 여부 판단
    document.getElementById("loginForm").addEventListener("submit", function () {
        if (rememberCheckbox.checked) {
            setCookie("rememberedId", usernameInput.value, 7); // 7일 저장
        } else {
            deleteCookie("rememberedId");
        }
    });

    // 쿠키 설정 함수
    function setCookie(name, value, days) {
        const expires = new Date();
        expires.setDate(expires.getDate() + days);
        document.cookie = name + "=" + encodeURIComponent(value) + ";expires=" + expires.toUTCString() + ";path=/";
    }

    // 쿠키 가져오기 함수
    function getCookie(name) {
        const match = document.cookie.match(new RegExp("(^| )" + name + "=([^;]+)"));
        if (match) return decodeURIComponent(match[2]);
        return null;
    }

    // 쿠키 삭제 함수
    function deleteCookie(name) {
        document.cookie = name + "=;expires=Thu, 01 Jan 1970 00:00:00 UTC;path=/;";
    }

    // --- 비밀번호 보이기/숨기기 기능 ---
    const toggle = document.getElementById("togglePassword");
    const passwordInput = document.getElementById("password");

    toggle.addEventListener("click", function () {
        const isPassword = passwordInput.type === "password";
        passwordInput.type = isPassword ? "text" : "password";

        toggle.classList.toggle("fa-eye");
        toggle.classList.toggle("fa-eye-slash");
    });
});
