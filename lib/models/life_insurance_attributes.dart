import 'package:flutter/cupertino.dart';

class LifePackage with ChangeNotifier {
  final String lifeInsuranceId;
  final String age_limits;
  final int max_benefits;
  final String medical_examination;
  final String package_name;
  final String parental_inclusion;
  final int premium;

  LifePackage(
      {required this.lifeInsuranceId,
      required this.age_limits,
      required this.max_benefits,
      required this.medical_examination,
      required this.package_name,
      required this.parental_inclusion,
      required this.premium});
}
