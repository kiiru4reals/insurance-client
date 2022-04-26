import 'package:flutter/cupertino.dart';
import 'package:hilleninsure/models/vehicle_underwriters_attributes.dart';

class VehicleInsurerProvider with ChangeNotifier {

  List<VehicleInsurer> get getVInsurer {
    return _myinsurers;
  }
  List<VehicleInsurer> _myinsurers = [
    VehicleInsurer(
      id: 'car1',
      name: 'Amaco',
      comprehensive_rate: 4.5,
      third_party_rate: 6000,
      imageUrl:
      'https://images-na.ssl-images-amazon.com/images/I/81%2Bh9mpyQmL._AC_SL1500_.jpg',
    ),
    VehicleInsurer(
      id: 'car1',
      name: 'UAP Oldmutual',
      comprehensive_rate: 4.5,
      third_party_rate: 6000,
      imageUrl:
      'https://images-na.ssl-images-amazon.com/images/I/81%2Bh9mpyQmL._AC_SL1500_.jpg',
    ),
    VehicleInsurer(
      id: 'car1',
      name: 'Jubilee',
      comprehensive_rate: 4.5,
      third_party_rate: 6000,
      imageUrl:
      'https://images-na.ssl-images-amazon.com/images/I/81%2Bh9mpyQmL._AC_SL1500_.jpg',
    ),
  ];

  List<VehicleInsurer> get insurer {
    return _myinsurers;
  }

  VehicleInsurer findById(String InsurerId) {
    return _myinsurers.firstWhere((element) => element.id == InsurerId);
  }
}
