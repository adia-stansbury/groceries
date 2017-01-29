$( document ).ready(function() {
  var startDate;

  $("#js-datepicker-start").datepicker({
    onSelect: function(date) { startDate = date }
  });

  $("#js-import-google-cal-events").click(function() {
    if(startDate == null) {
      startDate = $("#js-datepicker-start").datepicker('getDate');
    }
    startDate = $.datepicker.formatDate('yy-mm-dd', new Date(startDate));
    $("#js-start_date").val(startDate);
  });
});
