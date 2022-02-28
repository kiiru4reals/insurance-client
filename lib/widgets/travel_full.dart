import 'package:flutter/material.dart';
import 'package:hilleninsure/models/travel_insurance_attributes.dart';
import 'package:provider/provider.dart';

class TravelFull extends StatefulWidget {
  final String travelId;
  const TravelFull({required this.travelId});

  @override
  _TravelFullState createState() => _TravelFullState();
}

class _TravelFullState extends State<TravelFull> {
  @override
  Widget build(BuildContext context) {
    final travelAttr = Provider.of<Travel>(context);
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
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            travelAttr.destination,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            travelAttr.date_of_departure,
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
