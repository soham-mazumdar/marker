// import 'package:intl/intl.dart';

// class Helper {
//   // static final num ONE_MINUTE = 60000;
//   // static final num ONE_HOUR = 3600000;
//   // static final num ONE_DAY = 86400000;
//   // static final num ONE_WEEK = 604800000;
 
//   // static final String ONE_SECOND_AGO = "Before";
//   // static final String ONE_MINUTE_AGO = "minutes ago";
//   // static final String ONE_HOUR_AGO = "An hour ago";
//   // static final String ONE_DAY_AGO = "Days ago";
//   // static final String ONE_MONTH_AGO = "Before the month";
//   // static final String ONE_YEAR_AGO = "years ago";
 
//  //Time conversion
//   static String format(DateTime date) {
//     num _date = DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;
//     if (_date < 1 * 60000) {
//       num seconds = toSeconds(_date);
//       return (seconds <= 0 ? 1 : seconds).toInt().toString() + 'Before';
//     }
//     if (_date < 45 * 60000) {
//       num minutes = toMinutes(_date);
//       return (minutes <= 0 ? 1 : minutes).toInt().toString() + 'minutes ago"';
//     }
//     if (_date < 24 * 3600000) {
//       num hours = toHours(_date);
//       return (hours <= 0 ? 1 : hours).toInt().toString() + ' hour ago';
//     }
//     if (_date < 48 * 3600000) {
//       return "yesterday";
//     }
//     else{
//       return DateFormat('yyyy-MM-dd – kk:mm').format(date).toString();
//     }
//     // if (delta < 30 * 86400000) {
//     //   num days = toDays(delta);
//     //   return (days <= 0 ? 1 : days).toInt().toString() + 'Days ago';
//     // }
//     // if (delta < 12 * 4 * 604800000) {
//     //   num months = toMonths(delta);
//     //   return (months <= 0 ? 1 : months).toInt().toString() + 'Before the month';
//     // } else {
//     //   num years = toYears(delta);
//     //   return (years <= 0 ? 1 : years).toInt().toString() + 'years ago';
//     // }
//   }
 
//   static num toSeconds(num date) {
//     return date / 1000;
//   }
 
//   static num toMinutes(num date) {
//     return toSeconds(date) / 60;
//   }
 
//   static num toHours(num date) {
//     return toMinutes(date) / 60;
//   }
 
//   static num toDays(num date) {
//     return toHours(date) / 24;
//   }
 
//   static num toMonths(num date) {
//     return toDays(date) / 30;
//   }
 
//   static num toYears(num date) {
//     return toMonths(date) / 365;
//   }
// }
 