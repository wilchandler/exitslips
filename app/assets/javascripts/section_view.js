$("#mastery_by_section").ready(function() {
	var request = $.ajax({url:"/sections/show_bargraph", type: "get"})
	request.done(function(response){
		$("#mastery_by_section").append(response)	
	});
});

