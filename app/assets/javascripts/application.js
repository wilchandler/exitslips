// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery_ujs
//= require d3
//= require jquery
//= require jquery-ui.min.js
//= require jquery-readyselector
//= require_tree .

// $(document).ready( function () {
//     $('#section_table').DataTable({
//     	"ordering": true
//     });
// } );


// require fuse.min.js

// Smooth scroll for in page links
$(function(){
    var target, scroll;

    $("a[href*=#]:not([href=#])").on("click", function(e) {
        if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
            target = $(this.hash);
            target = target.length ? target : $("[id=" + this.hash.slice(1) + "]");

            if (target.length) {
                if (typeof document.body.style.transitionProperty === 'string') {
                    e.preventDefault();
                  
                    var avail = $(document).height() - $(window).height();

                    scroll = target.offset().top;
                  
                    if (scroll > avail) {
                        scroll = avail;
                    }

                    $("html").css({
                        "margin-top" : ( $(window).scrollTop() - scroll ) + "px",
                        "transition" : "1s ease-in-out"
                    }).data("transitioning", true);
                } else {
                    $("html, body").animate({
                        scrollTop: scroll
                    }, 1000);
                    return;
                }
            }
        }
    });

    $("html").on("transitionend webkitTransitionEnd msTransitionEnd oTransitionEnd", function (e) {
        if (e.target == e.currentTarget && $(this).data("transitioning") === true) {
            $(this).removeAttr("style").data("transitioning", false);
            $("html, body").scrollTop(scroll);
            return;
        }
    });
});



$('.grading-area').ready( function() {


  $('.sortable').draggable({revert: "invalid"})


  $('#correct-hit-box').droppable({
    activeClass: "ui-state-default",
    hoverClass: "ui-state-hover",
    drop: function(event, ui) {
      ui.draggable.remove();
      answerID = ui.draggable.attr("id");
      $.ajax({
        type: "PATCH",
        url: "/answers/"+answerID,
        data: {correct: "true"},
        success: function(response){
          console.log(response)
        },
        dataType: "text"
      })
    }
  });


  $('#incorrect-hit-box').droppable({
    activeClass: "ui-state-default",
    hoverClass: "ui-state-hover",
    drop: function(event, ui) {
      ui.draggable.remove();
      answerID = ui.draggable.attr("id")
      $.ajax({
        type: "PATCH",
        url: "/answers/"+answerID,
        data: {correct: "false"},
        success: function(response){
          console.log(response)
        },
        dataType: "json"
      })
    }
  });

  $('.hit-box').droppable({
    activeClass: "ui-state-default",
    hoverClass: "ui-state-hover",
    drop: function(event, ui) {
      ui.draggable.remove();
      answerID = ui.draggable.attr("id")
      $.ajax({
        type: "PATCH",
        url: "/answers/"+answerID,
        data: {correct: "false"},
        success: function(response){
          console.log(response)
        },
        dataType: "json"
      })
    }
  });


});
