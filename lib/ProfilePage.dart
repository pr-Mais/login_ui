import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
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
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                            ))),
                  )))
        ],
      ),
    );
  }
}
