$('#d').ready(() => {
    let d = $('#d');
    d.css({
        'left': ((window.innerWidth - d.width()) / 2) + 'px',
        'top': ((window.innerHeight - d.height()) / 2) + 'px'
    });
    $(window).resize(() => d.css({
        'left': ((window.innerWidth - d.width()) / 2) + 'px',
        'top': ((window.innerHeight - d.height()) / 2) + 'px'
    }));
});
