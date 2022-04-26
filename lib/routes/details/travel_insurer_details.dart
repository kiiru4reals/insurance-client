import 'package:flutter/material.dart';
import 'package:hilleninsure/constants/colors.dart';
import 'package:hilleninsure/provider/travel_insurance_provider.dart';
import 'package:provider/provider.dart';

class TravelInsurerDetails extends StatefulWidget {
  static const routeName = "/TravelInsurerDetails";

  @override
  _TravelInsurerDetailsState createState() => _TravelInsurerDetailsState();
}

class _TravelInsurerDetailsState extends State<TravelInsurerDetails> {
  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    final tiData = Provider.of<TravelInsurersProvider>(context);
    final tiId = ModalRoute.of(context)!.settings.arguments as String;
    final prodAttr = tiData.findById(tiId);

    return Scaffold(
      bottomSheet: Container(
        height: kBottomNavigationBarHeight * 0.8,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorsConsts.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        child: Material(
          color: Theme.of(context).backgroundColor,
          child: InkWell(
            onTap: () {},
            splashColor: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Text('Pay',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center),
                ),
                GradientIcon(
                  Icons.account_balance_wallet_outlined,
                  20,
                  LinearGradient(
                    colors: <Color>[
                      Colors.green,
                      Colors.yellow,
                      Colors.deepOrange,
                      Colors.orange,
                      // Colors.yellow[800],
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          CustomScrollView(
            // controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 4,
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            ColorsConsts.starterColor,
                            ColorsConsts.endColor,
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      centerTitle: true,
                      title: Row(
                        //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedOpacity(
                            duration: Duration(milliseconds: 300),
                            opacity: top <= 110.0 ? 1.0 : 0,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  height: kToolbarHeight / 1.8,
                                  width: kToolbarHeight / 1.8,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 1.0,
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          'https://images.unsplash.com/photo-1646588367903-336e0aa5cff8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  // 'top.toString()',
                                  prodAttr.packageName,
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      background: Image(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1646588367903-336e0aa5cff8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: userTitle('User Information')),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    userListTile(
                        'Package name', prodAttr.packageName, 0, context),
                    userListTile('Accidental Death', prodAttr.accidentalDeath,
                        1, context),
                    userListTile(
                        'Premium', 'KES. ${prodAttr.packagePrice}', 2, context),
                    userListTile(
                        'Covid inclusion', prodAttr.covidInclusion, 3, context),
                    userListTile('Emergency hospitalisation',
                        prodAttr.emergencyHospitalisation, 4, context),
                    userListTile('Hijack and hostage remuneration',
                        prodAttr.hijackHostage, 5, context),
                    userListTile('Hospital cash benefit',
                        prodAttr.hospitalCashBenefit, 6, context),
                    userListTile('Journey cancellation',
                        prodAttr.journeyCancellation, 7, context),
                    userListTile('Journey curtailment',
                        prodAttr.journeyCurtailment, 8, context),
                    userListTile(
                        'Legal expenses', prodAttr.legalExpenses, 9, context),
                    userListTile('Lost cash', prodAttr.lostCash, 10, context),
                    userListTile('Lost luggage', prodAttr.luggage, 11, context),
                    userListTile(
                        'Luggage delay', prodAttr.luggageDelay, 12, context),
                    userListTile('Permanent disability cover',
                        prodAttr.permanentDisability, 13, context),
                    userListTile('Permanent liability cover',
                        prodAttr.personalLiability, 14, context),
                    userListTile('Pre-exsisitng conditions cover',
                        prodAttr.preexistingConditions, 15, context),
                    userListTile('Single item limit', prodAttr.singleItemLimit,
                        16, context),
                    userListTile(
                        'Travelling delays', prodAttr.travelDelay, 17, context),
                    // userListTile('Request made', prodAttr.valid_date.toString(), 3, context),
                    // userListTile('Order', 'history', 3, context),
                    // userListTile('Email', 'Email sub', 0, context),
                    // userListTile('Phone number', '4555', 0, context),
                    // userListTile('Shipping address', '', 0, context),
                    // userListTile('joined date', 'date', 0, context),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget userListTile(
      String title, String subTitle, int index, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          onTap: () {},
          title: Text(title),
          subtitle: Text(subTitle),
        ),
      ),
    );
  }

  Widget userTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      ),
    );
  }
}

class GradientIcon extends StatelessWidget {
  GradientIcon(
    this.icon,
    this.size,
    this.gradient,
  );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
