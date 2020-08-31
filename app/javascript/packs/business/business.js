require('@rails/ujs').start()
require('@rails/activestorage').start()
require('jquery')
require('channels')
require('./vendor/bootstrap.bundle')
require('./custom')
require('./calendar/filter_select')
require('cocoon')
import "@fortawesome/fontawesome-free/js/all";

window.jQuery = $;
window.$ = $;

import toastr from 'toastr'
window.toastr = toastr

toastr.options = {
  closeButton: true,
  debug: false,
  newestOnTop: false,
  progressBar: true,
  positionClass: 'toast-top-right',
  preventDuplicates: false,
  onclick: null,
  showDuration: 300,
  hideDuration: 1000,
  timeOut: 10000,
  extendedTimeOut: 1000,
  showEasing: 'swing',
  hideEasing: 'linear',
  showMethod: 'fadeIn',
  hideMethod: 'fadeOut',
};
