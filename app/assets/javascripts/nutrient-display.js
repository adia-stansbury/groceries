$( document ).ready(function() {
  var groups = ["amino-acids", "lipids", "minerals", "proximates", "vitamins"];
  function toggleGroupDisplay(group) {
    $( ".plus-sign-" + group).click(function() {
      $( ".minus-sign-" + group).show();
      $( ".nutrient-info-" + group).show();
      $( ".plus-sign-" + group).hide();
    });
  }
  $( ".plus-sign" ).click(function(groups.forEach(toggleGroupDisplay)));
});
