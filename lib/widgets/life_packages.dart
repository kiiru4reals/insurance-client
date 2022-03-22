import 'package:flutter/material.dart';
import 'package:hilleninsure/models/life_insurance_attributes.dart';
import 'package:provider/provider.dart';

class ShowLifePackages extends StatefulWidget {
  final String lifeId;
  const ShowLifePackages({Key? key, required this.lifeId}) : super(key: key);

  @override
  _ShowLifePackagesState createState() => _ShowLifePackagesState();
}

class _ShowLifePackagesState extends State<ShowLifePackages> {
  @override
  Widget build(BuildContext context) {
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
        DataCell(Text('KES. ${PackagesAttr.premium}'))
      ]),
      DataRow(cells: [
        DataCell(Text("Pay now")),
        DataCell(ElevatedButton.icon(
          label: Text("Pay"),
          onPressed: (){},
          icon: Icon(Icons.account_balance_wallet_outlined),
        ))
      ]),

    ]);
  }
}
