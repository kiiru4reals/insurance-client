import 'package:flutter/material.dart';
import 'package:hilleninsure/models/life_insurance_attributes.dart';
import 'package:provider/provider.dart';

class LifeFull extends StatefulWidget {
  final String lifeId;
  const LifeFull({required this.lifeId});

  @override
  _LifeFullState createState() => _LifeFullState();
}

class _LifeFullState extends State<LifeFull> {
  @override
  Widget build(BuildContext context) {
    final lifeAttr = Provider.of<LifePackage>(context);
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
                            lifeAttr.package_name,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            lifeAttr.max_benefits.toString(),
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