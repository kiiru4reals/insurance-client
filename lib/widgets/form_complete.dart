import 'package:flutter/material.dart';

class CompletedForm extends StatefulWidget {
  const CompletedForm({Key? key}) : super(key: key);

  @override
  _CompletedFormState createState() => _CompletedFormState();
}

class _CompletedFormState extends State<CompletedForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Your form is completed!"),
    );
  }
}