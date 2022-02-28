import 'package:flutter/material.dart';
import 'package:hilleninsure/screens/home_page.dart';
import 'package:hilleninsure/screens/life_insurance.dart';
import 'package:hilleninsure/screens/travel_insurance.dart';
import 'package:hilleninsure/screens/my_cars.dart';
import 'package:hilleninsure/screens/user_info.dart';


class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarScreen';
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  List? _pages ;

  // var _pages;
  int _selectedIndex = 0;

  @override
  void initState() {
    _pages = [
      HomePage(),
      MyCars(),
      LifeInsurance(),
      TravelInsurance(),
      UserInfo(),
    ];
    // _pages = [
    //   {'page': HomeScreen(), 'title': 'Home Screen'},
    //   {'page': FeedsScreen(), 'title': 'Feeds screen'},
    //   {'page': SearchScreen(), 'title': 'Search Screen'},
    //   {'page': CartScreen(), 'title': 'CartScreen'},
    //   {'page': UserScreen(), 'title': 'UserScreen'}
    // ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(_pages[_selectedIndex]['title']),
      // ),
      body: _pages![_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        notchMargin: 3,
        clipBehavior: Clip.antiAlias,
        // elevation: 5,
        shape: CircularNotchedRectangle(),
        child: Container(
          // height: kBottomNavigationBarHeight * 0.8,
          decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 0.5),
              )),
          child: BottomNavigationBar(
            onTap: _selectedPage,
            backgroundColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).textSelectionColor,
            selectedItemColor: Colors.purple,
            currentIndex: _selectedIndex,
            selectedLabelStyle: TextStyle(fontSize: 15),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                tooltip: 'Home',
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.airport_shuttle),
                tooltip: 'Cars',
                label: 'Cars',
              ),
              BottomNavigationBarItem(
                activeIcon: null,
                icon: Icon(null), // Icon(
                //   Icons.search,
                //   color: Colors.transparent,
                // ),
                tooltip: 'Life',
                label: 'Life',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.flight_takeoff),
                tooltip: 'Travel',
                label: 'Travel',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                tooltip: 'Me',
                label: 'Me',
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        tooltip: 'Life',
        elevation: 5,
        child: (Icon(Icons.favorite_outlined)),
        onPressed: () {
          setState(() {
            _selectedIndex = 2;
          });
        },
      ),
    );
  }
}