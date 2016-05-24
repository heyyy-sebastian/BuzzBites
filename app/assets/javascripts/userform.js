"use strict";
$(document).ready(function() {
  var signUpClick = $("li#signUpClick");
  var loginClick = $("li#loginClick");
  var divUserSignUp = $("div#userSignUp");
  var divUserLogin = $("div#userLogin");

  signUpClick.click(function() {
    divUserSignUp.show("fast");
    divUserLogin.hide("fast");
  });

  loginClick.click(function() {
    divUserSignUp.hide("fast");
    divUserLogin.show("fast");
  });
});
