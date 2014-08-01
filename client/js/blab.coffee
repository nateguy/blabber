

getEmail = ->
	Meteor.user().emails[0].address

postMessage = (email, content) ->
	{ email: email, content: content }

Template.blab.current_email = ->
	console.log this
	return getEmail() == this.email

Template.blab.helpers
	allMessages: -> Messages.find({})

Template.blab.events

	'click #logout': (e)->
		console.log "logged out"
		Meteor.logout()
		Router.go('loginForm')
		e.preventDefault()
		false

Template.message_box.events
	'submit #message-box-form': (e, t) ->

		input = t.find('#message-box-content')
		message = input.value
		email = getEmail()
		input.value = ""

		Messages.insert(postMessage(email, message))
		e.preventDefault()
		false 

	'click #clearAllMsgs': (e)->
		messages = Messages.find({}).fetch()
		for m in messages
			id = m._id
			console.log id
			Messages.remove id
		e.preventDefault()
		false
