$( document ).ready(function() {
  var groups = ["amino-acids", "lipids", "minerals", "proximates", "vitamins"];
  $.each(groups, function( index, group ) {
    $( ".plus-sign-" + group).click(function() {
      $( ".minus-sign-" + group).show();
      $( ".nutrient-info-" + group).show();
      $( ".plus-sign-" + group).hide();
    });
  });
});
