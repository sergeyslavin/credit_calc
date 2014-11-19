var config = {
	post_calculate_url: "/calc"
};

$(function(){
	$('#reponse_table').hide();

	$('#calc_form').submit(function(){
		var form_data = $(this).serialize();

		$.post(config.post_calculate_url, form_data, function(response){
			if(response) {
				$('#message').empty();

				if(response.status == 200) {
					$('#message').removeClass('error');
					$('#message').addClass('success');
				} else {
					$('#message').removeClass('success');
					$('#message').addClass('error');
				}

				$('#reponse_table').empty();

				$('#message').append(response.message);
				if(response.status == 200) {
					var responseData = response.data;

					if(typeof response.method_type != undefined) {

							$('#reponse_table').show();

							if(response.method_type == "differentiated") {
									$('#reponse_table').append("<tr><td>Month</td><td>Repayment of loans</td><td>Paying off %</td><td>Overall contribution</td><td>Loan balance</td></tr>");

									$.each(responseData, function(key, value){
										$('#reponse_table').append("<tr><td>" + value.month + "</td><td>" + value.main_debt + "</td><td>" + value.percent + "</td><td>" + value.payment + "</td><td>" + value.rest + "</td></tr>");
									});

							} else {
									$('#reponse_table').append("<tr><td>Month</td><td>Repayment of loans</td><td>Paying off %</td><td>Overall contribution</td><td>Loan balance</td></tr>");

									$.each(responseData, function(key, value){
										$('#reponse_table').append("<tr><td>" + value.month + "</td><td>" + value.payment + "</td><td>" + value.percent + "</td><td>" + value.main_debt + "</td><td>" + value.rest + "</td></tr>");
									});
							}
					}
				}
			}
		});

	    return false;
	});
});
