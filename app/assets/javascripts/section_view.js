$(document).ready(function() {
	$("#cr_sect").on("click", function (e) {
		e.preventDefault();
		var request = $.ajax({ url: $(this).attr("href"), type: "get"});

		request.done(function(response){
			$(".cr_sectshow").append(response);
		});
	});

	// $("#cr_sect").on("click", function (e) {
	// 		e.preventDefault();
	// // 		$(".cr_sectshow").bPopup()

	// 		var bPop = $(".cr_sectshow").bPopup({
	// 										appendTo: 'body'
	// 										, zIndex: 2
	// 										, opacity: 0.5
	// 										, modalClose: true
											
	// 		});
	// });


	$(".cr_sectshow").on("submit", "form", function (e) {
		e.preventDefault();
		var link = $(this).attr("action");
		var data = $(this).serialize();
		var request = $.ajax({url: link, data: data, type: "post", dataType: "JSON"});

			request.done(function(data){
				$(".sect_show").append(data)
				// $(".cr_sectshow").remove()
		var new_link = "<li><a href=/sections/" + data.id + ">"+ data.section + "</li>";
				$("ul").prepend(new_link);
			
			});
	});
});

$(document).ready(function() {
	$("#cr_sect").on("click", function (e) {
			e.preventDefault();
	// 		$(".cr_sectshow").bPopup()
	$(".cr_sectshow").bPopup({
											appendTo: 'body'
											, zIndex: 2
											, opacity: 0.5
											, modalClose: true
											, transition: 'slideIn'
											
			});
	});
});




//show d3.js bargraph
$("#mastery_by_section").ready(function() {
	var request = $.ajax({url:"/sections/show_bargraph", type: "get"});
	request.done(function(response){
	$("#mastery_by_section").show();
	});
});



//For randomizing colors

// $(document).ready(function() {

//   d3.selectAll(".bar").style("fill", function() {
//   return "hsl(" + Math.random() * 360 + ",100%,50%)";
// 	});
// });

