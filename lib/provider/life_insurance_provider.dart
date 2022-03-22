import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hilleninsure/models/life_insurance_attributes.dart';
import 'package:flutter/cupertino.dart';

class LifePackageProvider with ChangeNotifier {
  List<LifePackage> _mylifepackages = [];

  List<LifePackage> get getlifePackages {
    return [..._mylifepackages];
  }

  Future<void> fetchLifePackages() async {
    // print('Fetch method is called');
    await FirebaseFirestore.instance
        .collection('lifeInsurers')
        .get()
        .then((QuerySnapshot lifeInsurersSnapshot) {
      _mylifepackages = [];
      lifeInsurersSnapshot.docs.forEach((element) {
        _mylifepackages.insert(
          0,
          LifePackage(
            lifeInsuranceId: element.get('lifeinsurerId'),
            age_limits: element.get('ageLimits'),
            max_benefits: int.parse(element.get('maxBenefits')),
            medical_examination: element.get('medicalExamination'),
            package_name: element.get('packageName'),
            parental_inclusion: element.get('parentInclusion'),
            premium: int.parse(element.get('premium')),
          ),
        );
      });
    });
  }
  LifePackage findById(String lifeId) {
    return _mylifepackages.firstWhere((element) => element.lifeInsuranceId == lifeId);
  }

}
