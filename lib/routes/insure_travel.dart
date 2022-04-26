import 'package:flutter/material.dart';
import 'package:hilleninsure/constants/colors.dart';
import 'package:hilleninsure/provider/travel_insurance_provider.dart';
import 'package:hilleninsure/services/global_methods.dart';
import 'package:hilleninsure/widgets/form_complete.dart';
import 'package:hilleninsure/widgets/no_travel_packages.dart';
import 'package:hilleninsure/widgets/travel_packages.dart';
import 'package:provider/provider.dart';

class TravelInsuranceApplicationForm extends StatefulWidget {
  static const routeName = "/TravelInsuranceApplicationForm";

  @override
  _TravelInsuranceApplicationFormState createState() => _TravelInsuranceApplicationFormState();
}

class _TravelInsuranceApplicationFormState extends State<TravelInsuranceApplicationForm> {
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final tiProvider = Provider.of<TravelInsurersProvider>(context);
    return tiProvider.gettravelinsurer.isEmpty
        ? Scaffold(
      appBar: AppBar(),
      body: NoTravelPackages(),
    )
        : Scaffold(
      appBar: AppBar(
        title: Text('Life insurance packages'),
      ),
      body: ListView.builder(
          itemCount: tiProvider.gettravelinsurer.length,
          itemBuilder: (BuildContext ctx, int index) {
            return ChangeNotifierProvider.value(
                value: tiProvider.gettravelinsurer[index],
                child: ShowTravelPackages(
                  travelinsurerId: tiProvider.gettravelinsurer.toString()[index],
                ));
          }),
    );
  }
}
