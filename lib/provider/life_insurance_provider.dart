import 'package:hilleninsure/models/life_insurance_attributes.dart';
import 'package:flutter/cupertino.dart';

class LifeInsuranceProvider with ChangeNotifier {

  List<Life> get getCovers {
    return _myCovers;
  }
  List<Life> _myCovers = [
    Life(
      id: 'Lifeinsurance1',
      full_name: 'Kiiru Maina',
      valid_date: '20/12/2021',
      expiry_date: '20/12/2022',
      premium: 65000.00,
      underwriter:
      'Some company',
    ),
    Life(
      id: 'Lifeinsurance2',
      full_name: 'Kiiru Maina',
      valid_date: '20/12/2021',
      expiry_date: '20/12/2022',
      premium: 65000.00,
      underwriter:
      'Some company',
    ),
    Life(
      id: 'LifeInsurance3',
      full_name: 'Kiiru Maina',
      valid_date: '20/12/2021',
      expiry_date: '20/12/2022',
      premium: 65000.00,
      underwriter:
      'Some company',
    ),
  ];

  List<Life> get life {
    return _myCovers;
  }

  Life findById(String lifeinsuranceId) {
    return _myCovers.firstWhere((element) => element.id == lifeinsuranceId);
  }
}
