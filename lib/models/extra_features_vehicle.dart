import 'package:flutter/cupertino.dart';

class NotificationSetting with ChangeNotifier{
  String title;
  bool value;


  NotificationSetting({
    required this.title,
    this.value = false,
  });
}