$( document ).ready(function() {
  var groups = ["amino-acids", "lipids", "minerals", "proximates", "vitamins"];
  $.each(groups, function( index, group ) {
    $( ".js-plus-sign-" + group).click(function() {
      $( ".js-plus-sign-" + group).hide();
      $( ".js-minus-sign-" + group).show();
      $( ".js-nutrient-info-" + group).show();
    });
    $( ".js-minus-sign-" + group).click(function() {
      $( ".js-minus-sign-" + group).hide();
      $( ".js-plus-sign-" + group).show();
      $( ".js-nutrient-info-" + group).hide();
    });
  });

  $( '.js-dropdown' ).select2({theme: 'bootstrap'});
});
