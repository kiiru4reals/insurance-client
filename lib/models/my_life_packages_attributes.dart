import 'package:flutter/material.dart';

class MyLifePackage with ChangeNotifier{
  final String packageId;
  final String packageName;

  MyLifePackage({required this.packageId, required this.packageName});
}
