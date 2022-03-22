import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hilleninsure/models/my_life_packages_attributes.dart';

class MyLifePackagesProvider with ChangeNotifier {
  List<MyLifePackage> _mylifepackages = [];

  List<MyLifePackage> get getmylifePackages {
    return [..._mylifepackages];
  }

  Future<void> fetchMyLifePackages() async {
    // print('Fetch method is called');
    await FirebaseFirestore.instance
        .collection('mylifePackages')
        .get()
        .then((QuerySnapshot lifeInsurersSnapshot) {
      _mylifepackages = [];
      lifeInsurersSnapshot.docs.forEach((element) {
        _mylifepackages.insert(
          0,
          MyLifePackage(
            packageId: element.get('packageId'),
            packageName: element.get('packageName'),
          ),
        );
      });
    });
  }
  MyLifePackage findById(String myPackageId) {
    return _mylifepackages.firstWhere((element) => element.packageId == myPackageId);
  }

}
