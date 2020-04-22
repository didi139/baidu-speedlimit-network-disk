"use strict";

// header-scroll-action
$(window).on('scroll', () => $('.baidu-navbar').css('background-color', $(window).scrollTop() === 0 ? 'transparent' : '#000'));

$(() => $('#login').click(() => {
    window.location = "../../login-signup/login-signup.jsp";
}));

$(()=>$('#logout').click(() => {
    clearCookie('username');
    clearCookie('password');
    location.reload();
}))();