import 'package:flutter/cupertino.dart';

class Car with ChangeNotifier {
  final String id;
  final String car_registration;
  final double premium;
  final String valid_date;
  final String expiry_date;
  final String certificateUrl;

  Car(
      {required this.id,
        required this.car_registration,
        required this.premium,
        required this.valid_date,
        required this.expiry_date,
        required this.certificateUrl});
}
