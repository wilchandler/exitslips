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
//= require d3
//= require jquery
//= require jquery-ui.min.js
//= require jquery_ujs
//= require jquery-readyselector
//= require_tree .

// $(document).ready( function () {
//     $('#section_table').DataTable({
//     	"ordering": true
//     });
// } );


// require fuse.min.js

$('.grading_area').ready( function() {


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


