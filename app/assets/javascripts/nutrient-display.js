$( document ).ready(function() {
  var groups = ["amino-acids", "lipids", "minerals", "proximates", "vitamins"];
  $.each(groups, function( index, group ) {
    $( ".plus-sign-" + group).click(function() {
      $( ".plus-sign-" + group).hide();
      $( ".minus-sign-" + group).show();
      $( ".nutrient-info-" + group).show();
    });
    $( ".minus-sign-" + group).click(function() {
      $( ".minus-sign-" + group).hide();
      $( ".plus-sign-" + group).show();
      $( ".nutrient-info-" + group).hide();
    });
  });
});
