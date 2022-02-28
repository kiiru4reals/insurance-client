import 'package:flutter/cupertino.dart';

class Travel with ChangeNotifier {
  final String id;
  final String travellers;
  final String destination;
  final String duration;
  final String date_of_departure;
  final String insurer;
  final String certificateUrl;

  Travel(
      {required this.id,
        required this.travellers,
        required this.destination,
        required this.duration,
        required this.date_of_departure,
        required this.insurer,
        required this.certificateUrl,});
}