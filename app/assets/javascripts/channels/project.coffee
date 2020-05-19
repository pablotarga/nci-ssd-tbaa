App.project = App.cable.subscriptions.create "ProjectChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('body').trigger 'app.updateProjectProgress', data

  changeProgress: ->
    # @perform 'changeProgress'
