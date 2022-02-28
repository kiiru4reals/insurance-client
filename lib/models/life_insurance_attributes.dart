import 'package:flutter/cupertino.dart';

class Life with ChangeNotifier {
  final String id;
  final String full_name;
  final double premium;
  final String valid_date;
  final String expiry_date;
  final String underwriter;

  Life(
      {required this.id,
        required this.full_name,
        required this.premium,
        required this.valid_date,
        required this.expiry_date,
        required this.underwriter});
}
