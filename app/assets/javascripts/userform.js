"use strict";
$(document).ready(function() {

  var signUpClick = $("li#signUpClick");
  var loginClick = $("li#loginClick");

  signUpClick.click(function() {
    $('#modal1').openModal();
  });

  loginClick.click(function() {
    $('#modal2').openModal();
  });

});
