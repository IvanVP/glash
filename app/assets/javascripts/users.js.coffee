jQuery ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next a').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 750
        $('.pagination').html("<img class='uslod' src='/assets/AjaxLoader.gif' alt='Loading...' title='Loading...' />")
        $.getScript(url)
    $(window).scroll()