$( document ).ready(function() {

  $('#js-datepicker').datepicker();

  $('#js-datepicker').on('changeDate', function() {
    $('#js-start_date').val(
      $('#js-datepicker').datepicker('getDate')
    );
  });
});
