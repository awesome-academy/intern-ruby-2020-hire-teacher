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

  $('input[placeholder]').placeholderLabel({
    placeholderColor: "#898989",
    labelColor: "black",
    labelSize: "14px",
    fontStyle: "normal",
    useBorderColor: true,
    inInput: true,
    timeMove: 200
  });

  $('.box-report').on('click', '.reply-btn', function(){
    console.log($(this).closest('div.example').children('.reply-form'));
    $(this).closest('div.example').children('.reply-form').toggle();
  })

  $('.box-report').on('click', '.see-more-btn', function(){
    let replies_class = '.' + $(this).closest('.content').children('.replies').attr('class').split(' ')[1];
    $(replies_class).toggle();
  })

  $('.scrollBox a.add_fields').
    data('association-insertion-method', 'append').
    data('association-insertion-node', '#list-invite');

  $("#open_notification").click(function()
  {
      $("#notificationContainer").fadeToggle(300);
      $("#notification_count").fadeOut("fast");
      $('.count-li').hide();
      return false;
  });

  $(document).click(function()
  {
      $("#notificationContainer").hide();
  });


  $("#notificationContainer").click(function()
  {
      return false;
  });
});
