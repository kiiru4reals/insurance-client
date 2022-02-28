import 'package:hilleninsure/models/life_insurance_attributes.dart';
import 'package:flutter/cupertino.dart';
import 'package:hilleninsure/models/travel_insurance_attributes.dart';

class TravelInsuranceProvider with ChangeNotifier {

  List<Travel> get getCovers {
    return _myCovers;
  }
  List<Travel> _myCovers = [
    Travel(
      id: 'Travelinsurance1',
      travellers: 'Individual',
      destination: 'Switzerland',
      duration: '12',
      date_of_departure: '20/12/2022',
      insurer: 'Sanlam',
      certificateUrl: '',
    ),
    Travel(
      id: 'Travelinsurance1',
      travellers: 'Individual',
      destination: 'Switzerland',
      duration: '12',
      date_of_departure: '20/12/2022',
      insurer: 'Sanlam',
      certificateUrl: '',
    ),
    Travel(
      id: 'Travelinsurance1',
      travellers: 'Individual',
      destination: 'Switzerland',
      duration: '12',
      date_of_departure: '20/12/2022',
      insurer: 'Sanlam',
      certificateUrl: '',
    ),
  ];

  List<Travel> get travel {
    return _myCovers;
  }

  Travel findById(String travelinsuranceId) {
    return _myCovers.firstWhere((element) => element.id == travelinsuranceId);
  }
}
