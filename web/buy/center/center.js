"use strict";

// header-scroll-action
$(window).on('scroll', () => $('.baidu-navbar').css('background-color', $(window).scrollTop() === 0 ? 'transparent' : '#000'));

$(() => $('#login').click(() => {
    window.location = "../../user/login.jsp";
}));

$(() => $('#home').click(() => {
    window.location = "../../disk/home.jsp";
}));

$(()=>$('#logout').click(() => {
    window.location = "../../uc?exit";
}));
