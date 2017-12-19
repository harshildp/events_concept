$(document).ready(function($) {
    // $('.table').dynatable({
    //     features: {
    //       paginate: false,
    //       recordCount: false,
    //       sorting: true
    //     }
    // });
    $('#register').hide();
    $('.btn-toggle').on('click', function() {
      $('#register, #login').slideToggle(200)
    });
    $('.btn-toggle').click(function() {
        $(this).find('.btn').toggleClass('active');  
        
        if ($(this).find('.btn-primary').size()>0) {
            $(this).find('.btn').toggleClass('btn-primary');
        }
        $(this).find('.btn').toggleClass('btn-default');  
    });
    $(".clickable-row").click(function(e) {
        ok_to_propagate = ! $(e.target).hasClass('clk');
        if (ok_to_propagate) {
            window.location = $(this).data("href")
        }
    });
    
    $(".auto-c").each(function(){
        $(this).children('tbody').children('tr').slice(0,4).addClass("expanded");        
    });
    
    $(".auto-c .expander").click(function() {
        var $table = $(this).closest("table");
        $table.addClass("expanded");
      });
      
      $('[data-toggle="tooltip"]').tooltip({delay: { "show": 500, "hide": 100 }, placement: 'bottom'});
});