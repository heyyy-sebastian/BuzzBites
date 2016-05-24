"use strict";
$(document).ready(function() {
  var signUpClick = $("li#signUpClick");
  var loginClick = $("li#loginClick");
  var divUserSignUp = $("div#userSignUp");
  var divUserLogin = $("div#userLogin");
  var cancelButton = $(".cancel-button");


  signUpClick.click(function() {
    divUserLogin.hide("fast");
    divUserSignUp.show("fast");
  });

  loginClick.click(function() {
    divUserSignUp.hide("fast");
    divUserLogin.show("fast");
  });

  cancelButton.on("click", function() {
    divUserSignUp.hide("fast");
    divUserLogin.hide("fast");
  });

});
