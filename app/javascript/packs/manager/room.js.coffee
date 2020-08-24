$ ->
  onAddFile = (event) ->
    file = event.target.files[0]
    url = URL.createObjectURL(file)
    thumbContainer = $(this).parent().siblings('td.thumb')
    if thumbContainer.find('img').length == 0
      thumbContainer.append '<img src="' + url + '" />'
    else
      thumbContainer.find('img').attr 'src', url

  $('input[type=file]').each ->
    $(this).change onAddFile
  $('body').on 'cocoon:after-insert', (e, addedPartial) ->
    $('input[type=file]', addedPartial).change onAddFile
  $('a.add_fields').data 'association-insertion-method', 'append'
  $('a.add_fields').data 'association-insertion-node', '#form-images tbody'
