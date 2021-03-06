class Motion.NewComponent extends UIComponent
  @register 'Motion.NewComponent'

  onCreated: ->
    super

    @canNew = new ComputedField =>
      # TODO: Allow only to those in "motion" role, which should be a sub-role of "member" role.
      Roles.userIsInRole Meteor.userId(), ['member', 'manager']

  currentDiscussionId: ->
    @ancestorComponent(Motion.ListComponent)?.currentDiscussionId()

  events: ->
    super.concat
      'submit .motion-new': @onSubmit

  onSubmit: (event) ->
    event.preventDefault()

    # TODO: We cannot use required for body input with trix.
    # TODO: Make a warning or something?
    return unless @hasBody()

    Meteor.call 'Motion.new',
      body: @$('[name="body"]').val()
      discussion:
        _id: @currentDiscussionId()
    ,
      (error, documentId) =>
        if error
          console.error "New motion error", error
          alert "New motion error: #{error.reason or error}"
          return

        event.target.reset()

  hasBody: ->
    # We require body to have at least some text content or a figure.
    $body = $($.parseHTML(@$('[name="body"]').val()))
    $body.text() or $body.has('figure').length
