jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')
  if $('#messages').length > 0
    messages_to_bottom = -> messages.scrollTop(messages.prop("scrollHeight"))
    messages_to_bottom()

    App.global_chat = App.cable.subscriptions.create {
      channel: "ChatroomsChannel"
      chatroom_id: messages.data('chatroom-id')
      },

      connected: ->
	        # Called when the subscription is ready for use on the server

      disconnected: ->
      # Called when the subscription has been terminated by the server

      received: (data) ->
        messages.append data['message']
        messages_to_bottom()
      # Data received

      send_message: (message, chatroom_id) ->
        @perform 'send_message', message: message, chatroom_id: chatroom_id

    $('#new_message').submit (e) ->
      $this = $(this)
      textarea = $this.find('#message_content')

      if $.trim(textarea.val()).length > 1
        App.global_chat.send_message textarea.val(), messages.data('chatroom-id')
        textarea.val('')

      e.preventDefault()
      return false
