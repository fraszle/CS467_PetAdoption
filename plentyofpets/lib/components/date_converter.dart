import 'package:cloud_firestore/cloud_firestore.dart';

// This data converter function takes a timestamp and coverts it to a
// MM/DD/YY string
String dateConverter(Timestamp tStamp) {
  DateTime tsDate = tStamp.toDate();
  String dateTime = tsDate.month.toString() +
      "/" +
      tsDate.day.toString() +
      "/" +
      tsDate.year.toString();

  return dateTime;
}
