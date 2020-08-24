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

import I18n from "i18n-js";

global.I18n = I18n;

$(document).on('turbolinks:load', function () {
  setTimeout(function() {
    $('#flash').slideUp();
  }, TIME_OUT);

  $('#add_js_btn').on('click', function() {
    addImageField();
  });

  $('.delete-btn').on('click', function() {
    $(this).parent().remove();
  });

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

function addImageField() {
  var length = document.getElementsByClassName('form-control-file').length;
  var div = document.createElement('div');
  div.className = 'flex-box';

  var input = document.createElement('input');
  var button = document.createElement('button');
  var i = document.createElement('i');

  input.type = 'file';
  input.name = 'room[images_attributes]['+ length +'][image]';
  input.className = 'form-control-file';
  input.id = 'room_images_attributes_' + length + '_image';

  button.type = 'button';
  button.id = 'remove_js_btn_' + length;
  button.className = 'btn btn-default btn-circle delete-btn animation-resize';
  button.onclick = () => {
    $(button).parent().remove();
  }

  i.className = 'fa fa-trash';

  button.appendChild(i);
  div.appendChild(input);
  div.appendChild(button);
  $('.image-container').append(div);
}

function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function(e) {
      $('#previewHolder').attr('src', e.target.result);
    }
    reader.readAsDataURL(input.files[0]);
  } else {
    alert('select a file to see preview');
    $('#previewHolder').attr('src', '');
  }
}

$('#filePhoto').change(function() {
  readURL(this);
});

const TIME_OUT = 3000;
const ROOM_NAME_MAXLENGTH = 30;
const ROOM_ADDRESS_MAXLENGTH = 50;
