import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:hilleninsure/models/life_insurance_attributes.dart';
import 'package:hilleninsure/services/global_methods.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ShowLifePackages extends StatefulWidget {
  final String lifeId;

  const ShowLifePackages({Key? key, required this.lifeId}) : super(key: key);

  @override
  _ShowLifePackagesState createState() => _ShowLifePackagesState();
}

class _ShowLifePackagesState extends State<ShowLifePackages> {
  String? _ref;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  GlobalMethods _globalMethods = GlobalMethods();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var uuid = Uuid();


  void setRef() {
    Random rand = Random();
    int number = rand.nextInt(2000);

    if (Platform.isAndroid) {
      setState(() {
        _ref = "AndroidRef1789$number";
      });
    } else {
      setState(() {
        _ref = "IOSRef1789$number";
      });
    }
  }

  void _makePayment(
      BuildContext context, String username, String email, int amount, String package) async {
    try {
      Flutterwave flutterwave = Flutterwave.forUIPayment(
          context: this.context,
          encryptionKey: "FLWSECK_TEST3dc5465e3215",
          publicKey: "FLWPUBK_TEST-b6880ed261e22926d4f1a08b64233ff7-X",
          currency: "KES",
          amount: "$amount",
          email: "$email",
          fullName: "$username",
          txRef: _ref!,
          isDebugMode: false,
          phoneNumber: "0742209350",
          acceptCardPayment: true,
          acceptUSSDPayment: false,
          acceptAccountPayment: false,
          acceptFrancophoneMobileMoney: false,
          acceptGhanaPayment: false,
          acceptMpesaPayment: true,
          acceptRwandaMoneyPayment: true,
          acceptUgandaPayment: false,
          acceptZambiaPayment: false);

      final ChargeResponse response =
          await flutterwave.initializeForUiPayments();
      if (response == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Transaction incomplete")));
      } else {
        ///
        if (response.status == "success") {
          print(response.data);
          print(response.message);
          _submitData(context, username.trim(), email.trim(), amount, package.trim());
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Transaction successful!")));
        } else {
          print(response.message);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Transaction failed")));
        }
      }
    } catch (error) {
      print("Unknown error $error");
    }
  }
  void _submitData(BuildContext context, String username, String email, int amount, String package) async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      try {
        if (_ref== null) {
          _globalMethods.authErrorHandle('No ref(only solved through code!)', context);
        } else {
          setState(() {
            _isLoading = true;
          });

          final User? user = _auth.currentUser;
          final _uid = user!.uid;
          final lifeclientId = uuid.v4();
          await FirebaseFirestore.instance
              .collection('InsuredLives')
              .doc(lifeclientId)
              .set({
            'vehicleId': lifeclientId,
            'subscribedPackage': "$package",
            'amountPaid': "$amount",
            'policyHolder': "$username",
            'userId': _uid,
            // 'requestMade': Timestamp.today().toString(),
            // 'expiryDate':
          });
          Navigator.canPop(context) ? Navigator.pop(context) : null;
        }
      } catch (error) {
        // _globalMethods.authErrorHandle(error.message, context);
        print('An Error Occurred ${error}');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  @override
  void initState() {
    setRef();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final _useremail = user!.email;
    final _username = user!.displayName;
    final PackagesAttr = Provider.of<LifePackage>(context);
    return DataTable(columns: [
      DataColumn(label: Text("Perks")),
      DataColumn(label: Text("Features"))
    ], rows: [
      DataRow(cells: [
        DataCell(Text("Package name")),
        DataCell(Text(PackagesAttr.package_name))
      ]),
      DataRow(cells: [
        DataCell(Text("Maximum benefits")),
        DataCell(Text(PackagesAttr.max_benefits.toString()))
      ]),
      DataRow(cells: [
        DataCell(Text("Medical examination")),
        DataCell(Text(PackagesAttr.medical_examination))
      ]),
      DataRow(cells: [
        DataCell(Text("Age limits")),
        DataCell(Text(PackagesAttr.age_limits))
      ]),
      DataRow(cells: [
        DataCell(Text("Parent inclusion")),
        DataCell(Text(PackagesAttr.parental_inclusion))
      ]),
      DataRow(cells: [
        DataCell(Text("Premium")),
        DataCell(Text(
          'KES. ${PackagesAttr.premium}',
        ))
      ]),
      DataRow(cells: [
        DataCell(Text("Pay now")),
        DataCell(ElevatedButton.icon(
          label: Text("Pay"),
          onPressed: () {
            final email = _useremail;
            final amount = PackagesAttr.premium;
            final username = _username;
            final package = PackagesAttr.package_name;

            if (email!.isEmpty || username!.isEmpty) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("No email")));
            } else {
              // Proceed to flutterwave
              _makePayment(context, username.trim(), email.trim(), amount, package.trim());
            }
          },
          icon: Icon(Icons.account_balance_wallet_outlined),
        ))
      ]),
    ]);
  }
}