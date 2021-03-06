class Meeting.EditComponent extends Meeting.OneComponent
  @register 'Meeting.EditComponent'

  onCreated: ->
    super

    @autorun (computation) =>
      meetingId = @currentMeetingId()
      @subscribe 'Meeting.forEdit', meetingId if meetingId

class Meeting.EditFormComponent extends UIComponent
  @register 'Meeting.EditFormComponent'

  onRendered: ->
    super

    Tracker.afterFlush =>
      # A bit of mangling to get cursor to focus at the end of the text.
      $title = @$('[name="title"]')
      title = $title.val()
      $title.focus().val('').val(title)

    # TODO: Check why it does not enable every time?
    # TODO: Enable when know how to get the value.
    #@$('.datepicker').pickadate()

  events: ->
    super.concat
      'submit .meeting-edit': @onSubmit

  onSubmit: (event) ->
    event.preventDefault()

    Meteor.call 'Meeting.update',
      _id: @data()._id
      title: @$('[name="title"]').val()
      startAt: @constructDatetime @$('[name="start-date"]').val(), @$('[name="start-time"]').val()
      endAt: @constructDatetime @$('[name="end-date"]').val(), @$('[name="end-time"]').val()
      description: @$('[name="description"]').val()
    ,
      (error, result) =>
        if error
          console.error "Update meeting error", error
          alert "Update meeting error: #{error.reason or error}"
          return

        FlowRouter.go 'Meeting.display',
          _id: @data()._id

  startAtDate: ->
    moment(@data().startAt).format 'YYYY-MM-DD'

  startAtTime: ->
    moment(@data().startAt).format 'HH:mm'

  endAtDate: ->
    moment(@data().endAt).format 'YYYY-MM-DD' if @data().endAt

  endAtTime: ->
    moment(@data().endAt).format 'HH:mm' if @data().endAt

FlowRouter.route '/meeting/edit/:_id',
  name: 'Meeting.edit'
  action: (params, queryParams) ->
    BlazeLayout.render 'MainLayoutComponent',
      main: 'Meeting.EditComponent'

    # We set PageTitle after we get meeting title.
