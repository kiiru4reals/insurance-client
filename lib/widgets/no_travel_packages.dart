import 'package:flutter/material.dart';
import 'package:hilleninsure/constants/colors.dart';
import 'package:hilleninsure/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';
class NoTravelPackages extends StatefulWidget {
  const NoTravelPackages({Key? key}) : super(key: key);

  @override
  _NoTravelPackagesState createState() => _NoTravelPackagesState();
}

class _NoTravelPackagesState extends State<NoTravelPackages> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Container(
          margin: EdgeInsets.only(top: 80),
          width: double.infinity,
          height: MediaQuery.of(context).size.height*.4,
          decoration: BoxDecoration(image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('images/emptywishlist.png')
          ),
          ),
        ),
        Text('Hello there are no insurance packages for now',
          style: TextStyle(color: Theme.of(context).textSelectionColor,
              fontSize: 36,
              fontWeight: FontWeight.w600
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 50,),
        Text('Contact site admin',
          style: TextStyle(color: themeChange.darkTheme ? Theme.of(context).disabledColor: ColorsConsts.subTitle,
              fontSize: 26,
              fontWeight: FontWeight.w600
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 50,
        ),
        Container(

          width: MediaQuery.of(context).size.width*.9,
          height: MediaQuery.of(context).size.height*.06,
          child: ElevatedButton(onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.cyanAccent.shade400)
                ),
                primary: Colors.redAccent,
              ),
              child: Text('Go back?'.toUpperCase(),
                style: TextStyle(color: themeChange.darkTheme ? Theme.of(context).disabledColor: ColorsConsts.subTitle,
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.center,
              )
          ),
        ),
      ],
    );
  }
}