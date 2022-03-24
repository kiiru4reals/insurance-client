import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/core/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:hilleninsure/constants/colors.dart';
import 'package:hilleninsure/provider/my_cars_provider.dart';
import 'package:provider/provider.dart';

class VehicleDetails extends StatefulWidget {
  static const routeName = "/VehicleDetails";

  @override
  _VehicleDetailsState createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  // late ScrollController _scrollController;
  var top = 0.0;
  String? _ref;

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
      BuildContext context, String username, String email, double amount, String insurer) async {
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
          isDebugMode: true,
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
          _submitData(context, username.trim(), email.trim(), amount, insurer.trim());
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Transaction successful!")));
        } else {
          print(response.message);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Transaction failed")));
        }
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  /*void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
  }*/

  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final _useremail = user!.email;
    final _username = user.displayName;
    final CarData = Provider.of<MyCarsProvider>(context);
    final carId = ModalRoute.of(context)!.settings.arguments as String;
    final prodAttr = CarData.findById(carId);

    return Scaffold(
      bottomSheet: Container(
        height: kBottomNavigationBarHeight * 0.8,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorsConsts.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        child: Material(
          color: Theme.of(context).backgroundColor,
          child: InkWell(
            onTap: (){
              final email = _useremail;
              final amount = prodAttr.premium;
              final username = _username;
              final vehicleId = prodAttr.vehicleId;
              final insurer = prodAttr.insurer;
              final paymentStatus = prodAttr.paymentStatus;
              if (insurer.isEmpty || username!.isEmpty || amount == 0.0 || email!.isEmpty) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Can't make payment! Call agency")));
              } else {
                // Proceed to flutterwave
                _makePayment(context, username.trim(), email.trim(), amount, insurer.trim());
              }
            },
            splashColor: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Text('Pay',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center),
                ),
                GradientIcon(
                  Icons.account_balance_wallet_outlined,
                  20,
                  LinearGradient(
                    colors: <Color>[
                      Colors.green,
                      Colors.yellow,
                      Colors.deepOrange,
                      Colors.orange,
                      // Colors.yellow[800],
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          CustomScrollView(
            // controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 4,
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            ColorsConsts.starterColor,
                            ColorsConsts.endColor,
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      centerTitle: true,
                      title: Row(
                        //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedOpacity(
                            duration: Duration(milliseconds: 300),
                            opacity: top <= 110.0 ? 1.0 : 0,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  height: kToolbarHeight / 1.8,
                                  width: kToolbarHeight / 1.8,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 1.0,
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          'https://images.unsplash.com/photo-1646588367903-336e0aa5cff8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  // 'top.toString()',
                                  prodAttr.car_registration,
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      background: Image(
                        image: NetworkImage(
                             'https://images.unsplash.com/photo-1646588367903-336e0aa5cff8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: userTitle('Vehicle information')),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    userListTile('Car registration', prodAttr.car_registration, 0, context),
                    userListTile('Insurer', prodAttr.insurer, 1, context),
                    userListTile('Premium', 'KES. ${prodAttr.premium}', 2, context),
                    // userListTile('Request made', prodAttr.valid_date.toString(), 3, context),
                    userListTile('Payment status', prodAttr.paymentStatus, 4, context),
                    // userListTile('Order', 'history', 3, context),
                    // userListTile('Email', 'Email sub', 0, context),
                    // userListTile('Phone number', '4555', 0, context),
                    // userListTile('Shipping address', '', 0, context),
                    // userListTile('joined date', 'date', 0, context),

                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      /*Stack(
        children: <Widget>[
          Container(
            foregroundDecoration: BoxDecoration(color: Colors.black12),
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            child: Image.network(
                'https://images.unsplash.com/photo-1646588367903-336e0aa5cff8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        userListTile('Registration Number',
                            prodAttr.car_registration, 0, context),
                        userListTile('Payment Status',
                            prodAttr.paymentStatus, 1, context),
                        userListTile('Date requested',
                            prodAttr.valid_date.toString(), 2, context),
                        // userListTile(title, subTitle, index, context)
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                            side: BorderSide.none),
                        color: Theme.of(context).backgroundColor,
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text(
                              'Pay'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textSelectionColor),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.payment,
                              color: Colors.green.shade700,
                              size: 19,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),*/
    );
  }

  Widget userListTile(
      String title, String subTitle, int index, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          onTap: () {},
          title: Text(title),
          subtitle: Text(subTitle),
        ),
      ),
    );
  }
  Widget userTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      ),
    );
  }

  void _submitData(BuildContext context, String username, String email, double amount, String insurer) {}
}
class GradientIcon extends StatelessWidget {
  GradientIcon(
      this.icon,
      this.size,
      this.gradient,
      );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
