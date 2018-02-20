$("#recipe_ingredient_ingredient_id").autocomplete({
  minLength: 3,
  delay: 1000,
  source: function(request, response) {
    var searchTerm = $("#recipe_ingredient_ingredient_id").val();
    $.get("/ingredients", { search_term: searchTerm }, function(data) {
      response($.map(data, function (item) {
        return {
          label: item.name,
          value: item.id,
        };
      }));
    });
  },
});
