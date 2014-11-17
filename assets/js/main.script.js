(function(){
	$('#calc_form').submit(function(e){
		e.preventDefault();
		console.log($(this).serialize());
	});
});