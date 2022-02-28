import 'package:hilleninsure/models/my_cars_attributes.dart';
import 'package:flutter/cupertino.dart';

class MyCarsProvider with ChangeNotifier {

  List<Car> get getCars {
    return _mycars;
  }
  List<Car> _mycars = [
    Car(
      id: 'car1',
      car_registration: 'KCX 001A',
      valid_date: '20/12/2021',
      expiry_date: '20/12/2022',
      premium: 65000.00,
      certificateUrl:
      'https://images-na.ssl-images-amazon.com/images/I/81%2Bh9mpyQmL._AC_SL1500_.jpg',
    ),
    Car(
      id: 'car1',
      car_registration: 'KCX 001A',
      valid_date: '20/12/2021',
      expiry_date: '20/12/2022',
      premium: 65000.00,
      certificateUrl:
      'https://images-na.ssl-images-amazon.com/images/I/81%2Bh9mpyQmL._AC_SL1500_.jpg',
    ),
    Car(
      id: 'car1',
      car_registration: 'KCX 001A',
      valid_date: '20/12/2021',
      expiry_date: '20/12/2022',
      premium: 65000.00,
      certificateUrl:
      'https://images-na.ssl-images-amazon.com/images/I/81%2Bh9mpyQmL._AC_SL1500_.jpg',
    ),
  ];

  List<Car> get cars {
    return _mycars;
  }

  Car findById(String vehicleId) {
    return _mycars.firstWhere((element) => element.id == vehicleId);
  }
}
