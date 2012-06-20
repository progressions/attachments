//= require 'oibootstrap/bootstrap-alert'
//= require 'oibootstrap/spinners.min'

/* Initialize spinners
================================================== */
$(document).ready(function(){

  // Standard Spinners
  $(".spinner-tiny").spin("tiny");
  $(".spinner-small").spin("small");
  $(".spinner-large").spin("large");

  // Giant Spinner
  var angle = 0;
  setInterval(function(){
    angle += 1;
    $(".spinner-giant").rotate(angle);
  },40);

})
