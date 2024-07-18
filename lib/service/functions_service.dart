import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FunctionsService {

  static String formatDateFromTimestamp(Timestamp? timestamp) {
    if (timestamp == null) {
      return '';
    } else {
      DateTime dateFromTimestamp =
          DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
      return DateFormat('EEE,dd-MMM-yyyy hh:mm a').format(dateFromTimestamp);
    }
  }


  static String formatDateToInitialValueString(Timestamp? timestamp) {
    if (timestamp == null) {
      return '';
    } else {
      DateTime dateFromTimestamp =
          DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
      return DateFormat('yyyy-MM-dd hh:mm').format(dateFromTimestamp);
    }
  }


}
