import 'package:flutter/material.dart';
import 'package:hilleninsure/models/my_cars_attributes.dart';
import 'package:hilleninsure/routes/details/car_details.dart';
import 'package:provider/provider.dart';

class ShowCars extends StatefulWidget {
  final String carId;

  const ShowCars({required this.carId});

  @override
  _ShowCarsState createState() => _ShowCarsState();
}

class _ShowCarsState extends State<ShowCars> {
  @override
  Widget build(BuildContext context) {
    final CarAttr = Provider.of<Car>(context);
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: 30.0, bottom: 10.0),
          child: Material(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5.0),
            elevation: 3.0,
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, VehicleDetails.routeName,
                  arguments: CarAttr.vehicleId),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
/*                    Container(
                      height: 80,
                      child: Image.network(CarAttr.certificateUrl),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),*/
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            CarAttr.car_registration,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            CarAttr.paymentStatus,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // positionedRemove(widget.productId),
      ],
    );
  }
}
