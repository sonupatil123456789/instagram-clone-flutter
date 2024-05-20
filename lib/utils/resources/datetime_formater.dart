import 'package:intl/intl.dart';

class DateTimeFormater{


  static String formatTime (String dateTimeString){
    if (dateTimeString.isNotEmpty) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedTime = DateFormat('h:mm a').format(dateTime); // 5:40 PM
    return formattedTime ;      
    }
    return '';
  }


  static String formatDate (String dateTimeString){
    if (dateTimeString.isNotEmpty) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('MM/dd/yyyy').format(dateTime); // 05/09/2024
    return formattedDate ;
    }
    return '';
  }


  static bool isDifferenceExactly24Hours(String comparedDate) {
  // Parse the date strings into DateTime objects
  DateTime dateTime1 = DateTime.parse(comparedDate);
  DateTime dateTime2 = DateTime.parse(DateTime.now().toString());

  print("Date one ${DateFormat('MM/dd/yyyy').format(dateTime1)} Date two ${DateFormat('MM/dd/yyyy').format(dateTime2)}");
  
  // Calculate the difference between the two DateTime objects
  Duration difference = dateTime1.difference(dateTime2).abs();
  
  // Check if the difference is exactly 24 hours (1440 minutes or 86400 seconds)
  return difference.inHours == 24;
}



}