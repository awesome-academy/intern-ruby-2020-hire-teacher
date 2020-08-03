$(document).ready(function(){
  $('#myInput').on('keyup', function() {
    var value = $(this).val().toLowerCase();
    $('.dropdown-menu li').filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
    $('.scrollBox a.add_fields').
      data('association-insertion-method', 'append').
      data('association-insertion-node', '#list-invite');
});
