# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

bind_signup = (->
  ($ ".event-signup").on "click", (->
    event_id = (($ this).data "event")
    ($.ajax "/bids/new/?event_id=" + event_id).always (-> location.reload())))

($ document).ready(bind_signup)
($ document).on("page:load", bind_signup)
