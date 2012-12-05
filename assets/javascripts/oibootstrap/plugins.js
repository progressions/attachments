$(function() {
  // make code pretty
  window.prettyPrint && prettyPrint()
})

// Set up popover
$("a[rel=popover]").popover();

// Set up tooltips
$("a[rel=tooltip]").tooltip();

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
