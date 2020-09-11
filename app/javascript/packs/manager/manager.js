require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')
require ('jquery')
require('jquery-validation')
require('packs/manager/jquery.min')
require('packs/manager/bootstrap.min')
require('packs/manager/metisMenu.min')
require('packs/manager/raphael.min')
require('packs/manager/morris.min')
require('packs/manager/morris-data')
require('packs/manager/startmin')
require('cocoon')

import I18n from 'i18n-js';

global.I18n = I18n;

$(document).on('turbolinks:load', function () {
  $('#form-images').on('change','input[type=file]', function (e) {
    let file_size = $(this)[0].files[0].size / 1024 / 1024;
    let tag = $(this).closest('td').next('td');
    validate_image(file_size, tag, e);
  });

  setTimeout(function() {
    $('#flash').slideUp();
  }, TIME_OUT);

  $('form[name="form_room"]').validate({
    rules: {
      'room[name]': {
        required: true,
        maxlength: ROOM_NAME_MAXLENGTH
      },
      'room[address]': {
        required: true,
        maxlength: ROOM_ADDRESS_MAXLENGTH
      }
    },
    messages: {
      'room[name]': {
        required: I18n.t('js.validates.room.name_required'),
        maxlength: I18n.t('js.validates.room.name_length')
      },
      'room[address]': {
        required: I18n.t('js.validates.room.address_required'),
        maxlength: I18n.t('js.validates.room.address_length')
      }
    },
    submitHandler: function(form) {
      form.submit();
    }
  });
});

function validate_image(file_size, tag, e) {
  if (file_size > 1) {
    alert(I18n.t('js.validates.image.max_size'));
    $(this).val(null);
  } else {
    tag.html(`<img src='${URL.createObjectURL(e.target.files[0])}' class='preview'>`);
  }
}

const TIME_OUT = 3000;
const ROOM_NAME_MAXLENGTH = 30;
const ROOM_ADDRESS_MAXLENGTH = 50;
