"use strict";
$(document).ready(function() {
  var signUpClick = $("li#signUpClick");
  var loginClick = $("li#loginClick");
  var divUserSignUp = $("div#userSignUp");

  signUpClick.click(function() {
    divUserSignUp.toggle();
  });

  loginClick.click(function() {
    alert("To be coded soon");
  });
});
