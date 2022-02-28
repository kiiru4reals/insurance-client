import 'package:flutter/cupertino.dart';

class VehicleInsurer with ChangeNotifier {
  final String id;
  final String name;
  final double comprehensive_rate;
  final int third_party_rate;
  final String imageUrl;

  VehicleInsurer(
      {required this.id,
        required this.name,
        required this.comprehensive_rate,
        required this.third_party_rate,
        required this.imageUrl,});
}