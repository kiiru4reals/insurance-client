import 'package:flutter/material.dart';
import 'package:hilleninsure/provider/travel_insurance_provider.dart';
import 'package:hilleninsure/services/global_methods.dart';
import 'package:hilleninsure/widgets/no_travel.dart';
import 'package:hilleninsure/widgets/travel_full.dart';
import 'package:provider/provider.dart';

class TravelInsurance extends StatefulWidget {
  static const routeName = "/TravelInsurance";

  @override
  _TravelInsuranceState createState() => _TravelInsuranceState();
}

class _TravelInsuranceState extends State<TravelInsurance> {
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final travelProvider = Provider.of<TravelInsurersProvider>(context);
    return travelProvider.gettravelinsurer.isEmpty
        ? Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Travel insurance: 0"),
      ),
      body: NoTravel(),
    )
        : Scaffold(
      appBar: AppBar(
        title: Text('My travel insurance policies(${travelProvider.gettravelinsurer.length})'),
      ),
      body: ListView.builder(
          itemCount: travelProvider.gettravelinsurer.length,
          itemBuilder: (BuildContext ctx, int index) {
            return ChangeNotifierProvider.value(
                value: travelProvider.gettravelinsurer[index],
                child: TravelFull(
                  travelId: travelProvider.gettravelinsurer.toString()[index],
                ));
          }),
    );
  }
}