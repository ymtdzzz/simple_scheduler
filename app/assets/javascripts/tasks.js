// $(document).ready(function() {
//   $('#calendar').fullCalendar({
//     header: {
//       left: 'prev,next today',
//       center: 'title',
//       right: 'month,agendaWeek,agendaDay'
//     },
//     navLinks: true,
//     selectable: true,
//     selectHelper: true,
//     select: function(start, end) {
//       var taskData;
//       if (title) {
//         eventData = {
//           title: title,
//           start: start,
//           end: end
//         };
//         $('#calendar').fullCalendar('renderEvent', taskData, true);
//       }
//       $('#calendar').fullCalendar('unselect');
//     },
//     events: '/tasks.json',
//     editable: false
//   });
// });

$(document).on('turbolinks:load', function() {
  $('#calendar').fullCalendar({
    header: {
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    },
    navLinks: true,
    selectable: true,
    selectHelper: true,
    select: function(start, end) {
      var taskData;
      if (title) {
        eventData = {
          title: title,
          start: start,
          end: end
        };
        $('#calendar').fullCalendar('renderEvent', taskData, true);
      }
      $('#calendar').fullCalendar('unselect');
    },
    events: '/tasks.json',
    editable: false
  });
});

$(document).on('turbolinks:load', function() {
  $('.datepicker').datetimepicker({
    format : "YYYY/MM/DD",
    icons: {
      previous: "fa fa-arrow-left",
      next: "fa fa-arrow-right"
    }
  });
  $('.datetimepicker').datetimepicker({
    format : "YYYY/MM/DD HH:mm",
    locale: 'ja'
  });
});