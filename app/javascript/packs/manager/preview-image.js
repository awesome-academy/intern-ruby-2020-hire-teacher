$(function () {
  function validate_image(file_size, tag, e) {
    if (file_size > 1) {
      alert("max size");
      $(this).val(null);
    } else {
      tag.html(`<img src='${URL.createObjectURL(e.target.files[0])}'>`);
    }
  }

  $('.images').on('change', 'input[type=file]', function (e) {
    let file_size = this.files[0].size / 1024 / 1024;
    let tag = $(this).closest('.imgs').find('.show-img');
    validate_image(file_size, tag, e)
  })

  $('input[type=file]').bind('change', function (e) {
    let file_size = this.files[0].size / 1024 / 1024;
    let tag = $(this).parent().find('.preview-avatar')
    validate_image(file_size, tag, e)
  });
})
