import 'package:hilleninsure/constants/theme_data.dart';
import 'package:hilleninsure/provider/dark_theme_provider.dart';
import 'package:hilleninsure/provider/life_insurance_provider.dart';
import 'package:hilleninsure/provider/my_cars_provider.dart';
import 'package:hilleninsure/provider/travel_insurance_provider.dart';
import 'package:hilleninsure/provider/vehicle_insurer_provider.dart';
import 'package:hilleninsure/routes/insure_car.dart';
import 'package:hilleninsure/routes/insure_life.dart';
import 'package:hilleninsure/routes/insure_travel.dart';
import 'package:hilleninsure/screens/life_insurance.dart';
import 'package:hilleninsure/screens/my_cars.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hilleninsure/screens/user_state.dart';
import 'package:provider/provider.dart';
import 'auth/login.dart';
import 'auth/sign_up.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error occured'),
                ),
              ),
            );
          }
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) {
                  return themeChangeProvider;
                }),
                ChangeNotifierProvider(
                  create: (_) => MyCarsProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => LifeInsuranceProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => TravelInsuranceProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => VehicleInsurerProvider(),
                ),
              ],
              child: Consumer<DarkThemeProvider>(
                  builder: (context, themeData, child) {
                    return MaterialApp(
                      title: 'Hilleninsure Client',
                      theme:
                      Styles.themeData(themeChangeProvider.darkTheme, context),
                      home: UserState(),
                      //initialRoute: '/',
                      routes: {
                        //   '/': (ctx) => LandingPage(),
                        VehicleInsuranceForm.routeName: (ctx) => VehicleInsuranceForm(),
                        TravelInsuranceApplicationForm.routeName: (ctx) =>
                            TravelInsuranceApplicationForm(),
                        LifeInsuranceForm.routeName: (ctx) => LifeInsuranceForm(),
                        MyCars.routeName: (ctx) => MyCars(),
                        LoginScreen.routeName: (ctx) => LoginScreen(),
                        SignUpScreen.routeName: (ctx) => SignUpScreen(),
                        LifeInsurance.routeName: (ctx) => LifeInsurance(),
                      },
                    );
                  }));
        });
  }
}