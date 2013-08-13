window.Helpers =

  formData: (selector) ->
    data = {}
    els = $(":input", selector)
    els.each (i, el) ->
      $el = $(el)
      name = $el.attr("name")
      value = undefined
      if $el.is("[type='checkbox']")
        value = $el.is(":checked")
      else if $el.is("[type='radio']")
        if $el.is(":checked")
          value = $el.val()
      else
        value = $el.val()
      data[name] = value if value
    data

  currentTimezoneOffset: ->
    dstPeriod = {}
    lastStartDay = 11
    lastEndDay = 4
    i = 2012

    while i < 2030
      if lastStartDay is 8
        lastStartDay = 11
      else
        lastStartDay--
      if lastEndDay is 1
        lastStartDay = 6
      else
        lastStartDay--
      dstPeriod[i] = [new Date(i, 2, lastStartDay), new Date(i, 10, lastEndDay)]
      i++
    today = new Date()
    offset = today.getTimezoneOffset()
    year = today.getFullYear()
    january = new Date(today.getFullYear(), 0, 1)
    januaryOffset = january.getTimezoneOffset()
    july = new Date(today.getFullYear(), 6, 1)
    julyOffset = july.getTimezoneOffset()
    dstObserved = januaryOffset is julyOffset
    dstDiff = Math.abs(januaryOffset - julyOffset)
    if dstObserved
      period = dstPeriod[year]
      offset += dstDiff  if today >= period[0] and today < period[1]
    (offset / 60) * -1
