import 'package:flutter/material.dart';
import 'package:hilleninsure/constants/colors.dart';
import 'package:hilleninsure/provider/life_insurance_provider.dart';
import 'package:hilleninsure/services/global_methods.dart';
import 'package:hilleninsure/widgets/form_complete.dart';
import 'package:hilleninsure/widgets/life_packages.dart';
import 'package:hilleninsure/widgets/no_life_packages.dart';
import 'package:provider/provider.dart';

class LifeInsuranceForm extends StatefulWidget {
  static const routeName = "/LifeInsuranceForm";

  @override
  _LifeInsuranceFormState createState() => _LifeInsuranceFormState();
}

class _LifeInsuranceFormState extends State<LifeInsuranceForm> {
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final lifeProvider = Provider.of<LifePackageProvider>(context);
    return lifeProvider.getlifePackages.isEmpty
        ? Scaffold(
      appBar: AppBar(),
      body: NoLifePackages(),
    )
        : Scaffold(
      appBar: AppBar(
        title: Text('Life insurance packages'),
      ),
      body: ListView.builder(
          itemCount: lifeProvider.getlifePackages.length,
          itemBuilder: (BuildContext ctx, int index) {
            return ChangeNotifierProvider.value(
                value: lifeProvider.getlifePackages[index],
                child: ShowLifePackages(
                  lifeId: lifeProvider.getlifePackages.toString()[index],
                ));
          }),
    );
  }
}
