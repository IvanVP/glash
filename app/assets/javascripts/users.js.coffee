# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
jQuery ->
  #$(window).scroll ->
  #  if $(window).scrollTop() > $(document).height() - $(window).height() - 150
   #   $.getScript($('.pagination .next').attr('href'))
 
  $("#users").infinitescroll
    navSelector: "nav.pagination" # selector for the paged navigation (it will be hidden)
    nextSelector: "nav.pagination a[rel=next]" # selector for the NEXT link (to page 2)
    itemSelector: "#users" # selector for all items you'll retrieve
   