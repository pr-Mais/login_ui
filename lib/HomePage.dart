import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_ui/CameraScreen.dart';
import 'package:login_ui/PoliceStations.dart';
import 'package:login_ui/popUpDialog.dart';
import 'package:login_ui/services/AuthenticationService.dart';
import 'package:login_ui/services/MessageService.dart';
import 'package:provider/provider.dart';
import 'ContactsPage.dart';
import 'package:geolocator/geolocator.dart';
import 'ProfilePage.dart';
import 'home.dart';
import 'package:geocoder/geocoder.dart';

import 'package:flutter/services.dart';
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  final List<Tab> myTabs = <Tab>[
    new Tab(text: 'Home'),
    new Tab(text: 'Contacts'),
    new Tab(text: 'Profile'),
  ];
  TabController tabController;
  LatLng _center ;
  LatLng _currentLocation;
  Position currentLocation;
  bool isLoading = false;
  var first;
  @override
  void initState() {
    super.initState();
    isLoading = false;
    tabController = new TabController(length: myTabs.length, vsync: this);
    tabController.addListener(_handleTabSelection);
    Provider.of<MessageService>(context, listen: false).init(context: context);
    getUserLocation();
  }
  Future<Position> locateUser() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    setState(() {
      isLoading = true;
    });

    currentLocation = await locateUser();
    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
    print(
        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    print('center $_center');

    final coordinates = new Coordinates(_center.latitude, _center.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    first = addresses.first;
    setState(() {
      isLoading = false;
    });

    print("${first.featureName} : ${first.addressLine}");
  }

  _handleTabSelection() {
    // setState(() {
      _selectedIndex = tabController.index;
      print(_selectedIndex);
    // });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   tabController.dispose();
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        bottomNavigationBar: new Material(
          color: Colors.white,
          child: new TabBar(
            controller: tabController,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                  text: 'Home',
                  icon: Icon(Icons.home,
                      color: tabController.index == 0
                          ? Theme.of(context).primaryColor
                          : Colors.grey)),
              Tab(
                  text: 'Contacts',
                  icon: Icon(Icons.group_work,
                      color: tabController.index == 1
                          ? Theme.of(context).primaryColor
                          : Colors.grey)),
              Tab(
                  text: 'Profile',
                  icon: Icon(Icons.person,
                      color: tabController.index == 2
                          ? Theme.of(context).primaryColor
                          : Colors.grey)),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Emergency Help\n Needed?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Current Location:  ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                        )),
                    isLoading?CircularProgressIndicator():
                    Text(first.addressLine.toString().substring(0,28)+"..",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                        ),overflow: TextOverflow.ellipsis,),
                  ],
                ),
                Center(
                    child: RaisedButton(
                        elevation: 20,
                        color: Color(0xffED553b),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(360.0)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CameraScreen()));
                        },
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Center(
                              child: Text("ALERT",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 42,
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                  ))),
                        ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      highlightElevation: 0.0,
                      splashColor: Color(0xffED553b),
                      // highlightColor: highlightColor,
                      elevation: 0.0,
                      color: Color(0xff20639B),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      child: SizedBox(
                        height: 100,
                        width: 160,
                        child: Center(
                          child: Text(
                            "Nearest Police Stations",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PoliceStations()));
                      },
                    ),
                    RaisedButton(
                      highlightElevation: 0.0,
                      splashColor: Color(0xffED553b),
                      // highlightColor: highlightColor,
                      elevation: 0.0,
                      color: Color(0xff20639B),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      child: SizedBox(
                        height: 100,
                        width: 160,
                        child: Center(
                          child: Text(
                            "My Alerts",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        Provider.of<MessageService>(context, listen: false)
                            .sendMessage();
                        popDialog(
                            title: "Emergency Alert",
                            context: context,
                            content:
                                "Sent to \n 1. Aakash \n 2. Anurag\n 3. Daddy\n 4. Dinakar\n 5. Karan Sharma\n\n Video clip Sent");
                      },
                    )
                  ],
                )
              ],
            ),
            ContactsPage(),
            ProfilePage(),
          ],
        ));
  }
}
