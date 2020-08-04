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

import I18n from 'i18n-js';

global.I18n = I18n;

$(document).on('turbolinks:load', function () {
  $('input[type=file]').bind('change', function (e) {
    let file_size = $(this)[0].files[0].size / 1024 / 1024;
    let tag = $(this).parent().parent().find('.show-img');
    validate_image(file_size, tag, e);
  });

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
  let length = document.getElementsByClassName('flex-box').length;
  let div = document.createElement('div');
  div.className = 'flex-box';
  div.innerHTML =
  ` <label for="room_images_attributes_${length}_image">
      <span class="btn btn-outline btn-link mr-8 animation-resize">
        <i class="fa fa-cloud-upload fa-2x"></i>
      </span>
    </label>
    <div class="imgs">
      <div hidden>
        <input class="images" type="file" name="room[images_attributes][${length}][image]"
          id="room_images_attributes_${length}_image" accept="image/*">
      </div>
      <div class="show-img">
      </div>
    </div>
    <button type="button" class="btn btn-default btn-circle delete-btn animation-resize">
      <i class="fa fa-trash"></i>
    </button>
    <hr>`
  $('.image-container').append(div);
  $(div).find('button').on('click', () => div.remove());
  $(div).find('input').bind('change', (e) => {
    let file_size = $(div).find('input')[0].files[0].size / 1024 / 1024;
    let tag = $(div).find('.show-img');
    validate_image(file_size, tag, e);
  });
}

function validate_image(file_size, tag, e) {
  if (file_size > 1) {
    alert(I18n.t('js.validates.image.max_size'));
    $(this).val(null);
  } else {
    tag.html(`<img src='${URL.createObjectURL(e.target.files[0])}' class='preview mr-8'>`);
  }
}

const TIME_OUT = 3000;
const ROOM_NAME_MAXLENGTH = 30;
const ROOM_ADDRESS_MAXLENGTH = 50;
