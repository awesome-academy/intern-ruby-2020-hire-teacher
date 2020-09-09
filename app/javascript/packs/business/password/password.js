$(function() {
  jQuery('#user_password').keyup(function(){
    jQuery('#result').html(checkStrength($('#user_password').val()))
  })

  function checkStrength(password){
    var strength = 0
    if (password.length < 6) {
      if (password.length == 0) {
        $('#result').empty()
        $('.bar-strong-password').css({
          'background-color': '',
          'height': '',
          'border-radius': ''
        })
      }
      else {
        $('#result').removeClass()
        $('#result').addClass('red')
        $('.bar-strong-password').css({
          'margin': '10px 5px 10px 35px',
          'background-color': 'red',
          'height': '3px',
          'width': '21%',
          'border-radius': '1.5px'
        })
        return "Too Short"
      }
    }

    if (password.length > 7) strength += 1

    if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/))  strength += 1

    if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/))  strength += 1

    if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/))  strength += 1

    if (password.match(/(.*[!,%,&,@,#,$,^,*,?,_,~].*[!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1

    if (strength < 2 && password.length > 0) {
      $('#result').removeClass()
      $('#result').addClass('weak');
      $('#result').addClass('orange');
      $('.bar-strong-password').css({
        'margin': '10px 5px 10px 35px',
        'background-color': 'orange',
        'height': '3px',
        'width': '42%',
        'border-radius': '1.5px'
      })
      return 'Weak'
    }
    else if (strength == 2 && password.length > 0) {
      $('#result').removeClass('orange');
      $('#result').addClass('green');
      $('.bar-strong-password').css({
        'margin': '10px 5px 10px 35px',
        'background-color': 'green',
        'height': '3px',
        'width': '63%',
        'border-radius': '1.5px'
      })
      return 'Good'
    }
    else if(strength > 2 && password.length > 0){
      $('#result').removeClass('red')
      $('#result').removeClass('orange')
      $('#result').addClass('strong')
      $('#result').addClass('green')
      $('.bar-strong-password').css({
        'margin': '10px 5px 10px 35px',
        'background-color': 'green',
        'height': '3px',
        'width': '84%',
        'border-radius': '1.5px'
      })
      return 'Strong'
    }
  }
});
