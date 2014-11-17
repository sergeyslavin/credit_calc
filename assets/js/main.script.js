var config = {
	post_calculate_url: "/calc"
};

$(function(){
	$('#calc_form').submit(function(){
		var form_data = $(this).serialize();

		$.post(config.post_calculate_url, form_data).done(function(data){

		});
		
	    return false;
	});
});