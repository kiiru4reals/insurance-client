import 'package:flutter/material.dart';
import 'package:hilleninsure/models/travel_insurance_attributes.dart';
import 'package:hilleninsure/routes/details/travel_insurer_details.dart';
import 'package:provider/provider.dart';

class ShowTravelPackages extends StatefulWidget {
  final String travelinsurerId;
  const ShowTravelPackages({Key? key, required this.travelinsurerId}) : super(key: key);

  @override
  _ShowTravelPackagesState createState() => _ShowTravelPackagesState();
}

class _ShowTravelPackagesState extends State<ShowTravelPackages> {
  @override
  Widget build(BuildContext context) {
    final travelAttr = Provider.of<TravelInsurer>(context);
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
              onTap: () => Navigator.pushNamed(context, TravelInsurerDetails.routeName,
                  arguments: travelAttr.travelinsurerId),
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
                            travelAttr.packageName,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            travelAttr.packagePrice.toString(),
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
