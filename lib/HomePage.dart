import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'ContactsPage.dart';
import 'ProfilePage.dart';

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

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: myTabs.length, vsync: this);
    tabController.addListener(_handleTabSelection);
  }

  _handleTabSelection() {
    setState(() {
      _selectedIndex = tabController.index;
      print(_selectedIndex);
    });
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

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
                      fontWeight: FontWeight.w500,
                      fontSize: 40,
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                    )),
                Center(
                    child: RaisedButton(
                        color: Color(0xffED553b),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(360.0)),
                        onPressed: () {},
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Center(
                              child: Text("ALERT",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 40,
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
                        height: 80,
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
                      onPressed: () {},
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
                        height: 80,
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
                      onPressed: () {},
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
