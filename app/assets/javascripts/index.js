    $('#register').hide();
    $('.btn-toggle').on('click', function () {
        $('#register, #login').slideToggle(200)
    });
    $('.btn-toggle').click(function () {
        console.log('flipping')
        $(this).find('.btn').toggleClass('active');

        if ($(this).find('.btn-primary').size() > 0) {
            $(this).find('.btn').toggleClass('btn-primary');
        }
        $(this).find('.btn').toggleClass('btn-default');
    });
    $(".clickable-row").click(function (e) {
        ok_to_propagate = !$(e.target).hasClass('clk');
        if (ok_to_propagate) {
            window.location = $(this).data("href")
        }
    });

    $(".auto-c").each(function () {
        $(this).children('tbody').children('tr').slice(0, 4).addClass("expanded");
    });

    $(".auto-c .expander").click(function () {
        var $table = $(this).closest("table");
        $table.addClass("expanded");
    });

    $('[data-toggle="tooltip"]').tooltip({ delay: { "show": 500, "hide": 100 }, placement: 'bottom' });

    // var images = ['/assets/event1.jpg', '/assets/event3.jpeg', '/assets/event4.jpg', '/assets/event5.jpeg']
    // var usedImages = { 0: true };
    // var count = 1;

    // function randImage() {
    //     var len = images.length;
    //     var idx = Math.floor(Math.random() * len)
    //     if (!usedImages[idx]) {
    //         $('#newEventImg').fadeOut(function () {
    //             $(this).attr('src', images[idx]).fadeIn();
    //         });
    //         console.log(usedImages)
    //         usedImages[idx] = true;
    //         count++;
    //         if (count === len) {
    //             count = 0;
    //             usedImages = {};
    //         }
    //     } else {
    //         randImage();
    //     }
    // }
    // setInterval(randImage, 5000);
    
    // var ImageArray = ['/assets/event1.jpg', '/assets/event3.jpeg', '/assets/event4.jpg', '/assets/event5.jpeg']

    // var i = 1
    // function imageSequence() {
    //     $('#newEventImg').fadeOut(function () {
    //         $(this).attr('src', ImageArray[i]).fadeIn();
    //     });
    //     i++;
    //     if (i === ImageArray.length) {
    //         i = 0;
    //     }
    // }
    // setInterval(imageSequence, 5000);

// $(document).ready(ready);
// $(document).on('turbolinks:load', ready);