// $("#recipe_ingredient_ingredient_id").autocomplete({
//   minLength: 3,
//   delay: 1000,
//   source: function(request, response) {
//     var searchTerm = $("#recipe_ingredient_ingredient_id").val();
//     $.get("/ingredients", { search_term: searchTerm }, function(data) {
//       response($.map(data, function (item) {
//         return {
//           label: item.name,
//           value: item.id,
//         };
//       }));
//     });
//   },
// });

$(document).ready(function() {
  $(".js-ingredients").select2({
    ajax: {
      url: "/ingredients",
      dataType: 'json',
      delay: 250,
      data: function(params) {
        return { search: params.term };
      },
      processResults: function (data, params) {
        return { results: data.items }
      },
      cache: true
    },
    placeholder: 'Search for ingredient...',
    minimumInputLength: 3,
  });
});
