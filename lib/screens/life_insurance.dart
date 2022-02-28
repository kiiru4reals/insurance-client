import 'package:flutter/material.dart';
import 'package:hilleninsure/provider/life_insurance_provider.dart';
import 'package:hilleninsure/services/global_methods.dart';
import 'package:hilleninsure/widgets/life_full.dart';
import 'package:hilleninsure/widgets/no_life.dart';
import 'package:provider/provider.dart';

class LifeInsurance extends StatefulWidget {
  static const routeName = "/LifeInsurance";

  @override
  _LifeInsuranceState createState() => _LifeInsuranceState();
}

class _LifeInsuranceState extends State<LifeInsurance> {
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final lifeProvider = Provider.of<LifeInsuranceProvider>(context);
    return lifeProvider.getCovers.isEmpty
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Life insurance: 0"),
            ),
            body: NoLife(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Life insurance (${lifeProvider.getCovers.length})'),
            ),
            body: ListView.builder(
                itemCount: lifeProvider.getCovers.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return ChangeNotifierProvider.value(
                      value: lifeProvider.life[index],
                      child: LifeFull(
                        lifeId: lifeProvider.getCovers.toString()[index],
                      ));
                }),
          );
  }
}
