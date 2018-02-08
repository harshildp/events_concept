var ImageArray = ['/assets/event1.jpg', '/assets/event3.jpeg', '/assets/event4.jpg', '/assets/event5.jpeg']
    window.clearInterval(inter)
    var i = 1
    function imageSequence() {
        $('#newEventImg').fadeOut(function () {
            $(this).attr('src', ImageArray[i]).fadeIn();
        });
        i++;
        if (i === ImageArray.length) {
            i = 0;
        }
    }
    var inter = setInterval(imageSequence, 5000);