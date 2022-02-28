import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:hilleninsure/routes/insure_car.dart';
import 'package:hilleninsure/routes/insure_life.dart';
import 'package:hilleninsure/routes/insure_travel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Homepage"),
          centerTitle: true,
/*          actions: [
            IconButton(onPressed: () async {
              Navigator.pop(context);
              await _auth.signOut();
            }, icon: Icon(Icons.ten_k))
          ],*/
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView(
              children: [
                InkWell(
                  onTap: () => Navigator.of(context)
                      .pushNamed(VehicleInsuranceForm.routeName),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.airport_shuttle,
                          size: 48,
                          color: Colors.white,
                        ),
                        Text(
                          "Vehicle insurance",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context)
                      .pushNamed(TravelInsuranceApplicationForm.routeName),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.flight_takeoff,
                          size: 48,
                          color: Colors.white,
                        ),
                        Text(
                          "Travel Insurance",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context)
                      .pushNamed(LifeInsuranceForm.routeName),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_outlined,
                          size: 48,
                          color: Colors.white,
                        ),
                        Text(
                          "Life Insurance",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
              ],
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            ),
          ),
        ));
  }
}