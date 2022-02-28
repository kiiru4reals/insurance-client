import 'package:flutter/material.dart';
import 'package:hilleninsure/provider/my_cars_provider.dart';
import 'package:hilleninsure/services/global_methods.dart';
import 'package:hilleninsure/widgets/mycars_full.dart';
import 'package:hilleninsure/widgets/no_cars.dart';
import 'package:provider/provider.dart';

class MyCars extends StatefulWidget {
  static const routeName = "/MyCars";

  @override
  _MyCarsState createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final carsProvider = Provider.of<MyCarsProvider>(context);
    return carsProvider.getCars.isEmpty
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("My cars: 0"),
            ),
            body: NoCars(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('My Cars(${carsProvider.getCars.length})'),
            ),
            body: ListView.builder(
                itemCount: carsProvider.getCars.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return ChangeNotifierProvider.value(
                      value: carsProvider.cars[index],
                      child: ShowCars(
                        carId: carsProvider.getCars.toString()[index],
                      ));
                }),
          );
  }
}
