jQuery ->
	$('#new_vote').find('.btn').addClass('disabled').on 'click', (event) ->
		if ($(event.target).hasClass('disabled'))
			event.preventDefault()
	$('#name').on 'keyup', (event) ->
		console.log($('#name').val())
		if ($('#name').val() != '' || $('#title').val() != '')
			$('#new_vote').find('.btn').removeClass('disabled')
		else
			$('#new_vote').find('.btn').addClass('disabled')
	$('#title').on 'keyup', (event) ->
		if ($('#name').val() != '' || $('#title').val() != '')
			$('#new_vote').find('.btn').removeClass('disabled')
		else
			$('#new_vote').find('.btn').addClass('disabled')