# TODO: Make a component once the animations hook bug is fixed.
#class UpvoteableButton extends UIComponent
#  @register 'UpvoteableButton'

class share.UpvoteableMixin extends UIMixin
  onCreated: ->
    super

    @canUpvote = new ComputedField =>
      # TODO: Allow only those in "upovote" role, which should be a sub-role of "member" role.
      'upvote' if Roles.userIsInRole(Meteor.userId(), 'member') and @data() and Meteor.userId() isnt @data().author._id and Meteor.userId() not in _.pluck(_.pluck(@data().upvotes or [], 'author'), '_id')

    @canRemoveUpvote = new ComputedField =>
      'remove-upvote' if Meteor.userId() and @data() and Meteor.userId() isnt @data().author._id and Meteor.userId() in _.pluck(_.pluck(@data().upvotes or [], 'author'), '_id')

  events: ->
    super.concat
      'click .upvote': @onUpvote
      'click .remove-upvote': @onRemoveUpvote

  _methodPrefix: ->
    @callFirstWith(null, 'methodPrefix') or throw new Error "Missing method prefix."

  _contentName: ->
    @callFirstWith(null, 'contentName') or throw new Error "Missing content name."

  onUpvote: (event) ->
    event.preventDefault()

    Meteor.call "#{@_methodPrefix()}.upvote", @data()._id, (error, result) =>
      if error
        console.error "Upvote error", error
        alert "Upvote error: #{error.reason or error}"
        return

  onRemoveUpvote: (event) ->
    event.preventDefault()

    Meteor.call "#{@_methodPrefix()}.removeUpvote", @data()._id, (error, result) =>
      if error
        console.error "Remove upvote error", error
        alert "Remove upvote error: #{error.reason or error}"
        return

  upvoteTitle: ->
    return if @canUpvote() or @canRemoveUpvote()

    return title: "Sign in to upvote." unless Meteor.userId()

    title: "You cannot upvote your #{@_contentName()}."
