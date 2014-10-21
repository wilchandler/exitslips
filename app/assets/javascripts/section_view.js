$("#mastery_by_section").ready(function() {
	var request = $.ajax({url:"/sections/show_bargraph", type: "get"})
	request.done(function(response){
	console.log(response);
	$("#mastery_by_section").show();


	});
});

