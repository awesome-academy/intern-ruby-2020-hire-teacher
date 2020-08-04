require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')
require ('jquery')

require('packs/manager/jquery.min')
require('packs/manager/bootstrap.min')
require('packs/manager/metisMenu.min')
require('packs/manager/raphael.min')
require('packs/manager/morris.min')
require('packs/manager/morris-data')
require('packs/manager/startmin')

$(document).on('turbolinks:load', function () {
  setTimeout(function() {
    $('#flash').slideUp();
  }, TIME_OUT);
  $('#add_js_btn').click( function() {
    addImageField();
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
  button.className = 'btn btn-default btn-circle';
  button.onclick = button.onclick = () => {
    button.parentElement.parentElement.removeChild(button.parentElement);
  };

  i.className = 'fa fa-trash';

  button.appendChild(i);


  div.appendChild(input);
  div.appendChild(button);
  $('.image-container').append(div);
}

const TIME_OUT = 3000;
