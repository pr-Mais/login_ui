import 'package:flutter/material.dart';
import 'clipper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  String _email;
  String _password;
  String _displayName;
  bool _obsecure = false;

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).primaryColor;

    //GO logo widget
    Widget logo() {
      return Center(
          child: Padding(
        padding: EdgeInsets.only(top: 150),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 240,
          child: Stack(
            children: <Widget>[
              Positioned(
                width: 150,
                height: 150,
                left: MediaQuery.of(context).size.width / 3,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  width: 150,
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 3.4,
                top: 5,
                child: Text(
                  "GO",
                  style: TextStyle(
                    fontSize: 112,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                width: 190,
              ),
              Positioned(
                width: 60,
                height: 60,
                top: 140,
                left: 260,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
              ),
              Positioned(
                width: 30,
                height: 30,
                top: 200,
                left: 230,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ));
    }

    //input widget
    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obsecure) {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: obsecure,
          style: TextStyle(fontSize: 20, ),
          decoration: InputDecoration(
            
              hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              hintText: hint,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 3,
                ),
              ),
              prefixIcon: Padding(
                child: IconTheme(
                  data: IconThemeData(color: Theme.of(context).primaryColor),
                  child: icon,
                ),
                padding: EdgeInsets.only(left: 30, right: 10),
              )),
        ),
      );
    }

    //button widget
    Widget _button(String text, Color splashColor, Color highlightColor,
        Color fillColor, Color textColor, void function()) {
      return RaisedButton(
        highlightElevation: 0.0,
        splashColor: splashColor,
        highlightColor: highlightColor,
        elevation: 0.0,
        color: fillColor,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: textColor, fontSize: 20),
        ),
        onPressed: () {
          function();
        },
      );
    }

    //login and register fuctions

    void _loginUser() {
      _email = _emailController.text;
      _password = _passwordController.text;
      _emailController.clear();
      _passwordController.clear();
    }

    void _registerUser() {
      _email = _emailController.text;
      _password = _passwordController.text;
      _displayName = _nameController.text;
      _emailController.clear();
      _passwordController.clear();
      _nameController.clear();
    }

    void _loginSheet() {
      _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
        return DecoratedBox(
          decoration: BoxDecoration(color: Theme.of(context).canvasColor),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0)),
            child: Container(
              child: ListView(
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 10,
                          top: 10,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _emailController.clear();
                              _passwordController.clear();
                            },
                            icon: Icon(
                              Icons.close,
                              size: 30.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    height: 50,
                    width: 50,
                  ),
                  SingleChildScrollView(
                    child: Column(children: <Widget>[
                      Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                width: 130,
                                height: 130,
                                left: MediaQuery.of(context).size.width / 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor),
                                  width: 150,
                                ),
                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width / 3.1,
                                top: 40,
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    fontSize: 41.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                width: 190,
                              ),
                              Positioned(
                                width: 60,
                                height: 60,
                                top: 140,
                                left: 260,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                ),
                              ),
                              Positioned(
                                width: 30,
                                height: 30,
                                top: 200,
                                left: 230,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: _input(Icon(Icons.email), "EMAIL",
                            _emailController, false),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: _input(Icon(Icons.lock), "PASSWORD",
                            _passwordController, true),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          child: _button("LOGIN", Colors.white, primary,
                              primary, Colors.white, _loginUser),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ]),
                  ),
                ],
              ),
              height: MediaQuery.of(context).size.height/1.1,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
            ),
          ),
        );
      });
    }

    void _registerSheet() {
      _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
        return DecoratedBox(
          decoration: BoxDecoration(color: Theme.of(context).canvasColor),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0)),
            child: Container(
              child: ListView(
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 10,
                          top: 10,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _emailController.clear();
                              _passwordController.clear();
                              _nameController.clear();
                            },
                            icon: Icon(
                              Icons.close,
                              size: 30.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    height: 50,
                    width: 50,
                  ),
                  SingleChildScrollView(
                    child: Column(children: <Widget>[
                      Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                width: 130,
                                height: 130,
                                left: MediaQuery.of(context).size.width / 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor),
                                  width: 150,
                                ),
                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width / 3.1,
                                top: 30,
                                child: Text(
                                  "REGI",
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                width: 190,
                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width / 2.6,
                                top: 60,
                                child: Text(
                                  "STER",
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                width: 190,
                              ),
                              Positioned(
                                width: 60,
                                height: 60,
                                top: 140,
                                left: 260,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                ),
                              ),
                              Positioned(
                                width: 30,
                                height: 30,
                                top: 200,
                                left: 230,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: _input(Icon(Icons.account_circle),
                            "DISPLAY NAME", _nameController, false),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: _input(Icon(Icons.email), "EMAIL",
                            _emailController, false),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: _input(Icon(Icons.lock), "PASSWORD",
                            _passwordController, true),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          child: _button("REGISTER", Colors.white, primary,
                              primary, Colors.white, _registerUser),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ]),
                  ),
                ],
              ),
              height: MediaQuery.of(context).size.height/1.1,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
            ),
          ),
        );
      });
    }

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: <Widget>[
            logo(),
            Padding(
              child: Container(
                child: _button("LOGIN", primary, Colors.white, Colors.white,
                    primary, _loginSheet),
                height: 50,
              ),
              padding: EdgeInsets.only(top: 80, left: 20, right: 20),
            ),
            Padding(
              child: Container(
                child: OutlineButton(
                  highlightedBorderColor: Colors.white,
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                  highlightElevation: 0.0,
                  splashColor: Colors.white,
                  highlightColor: Theme.of(context).primaryColor,
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  child: Text(
                    "REGISTER",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  onPressed: () {
                    _registerSheet();
                  },
                ),
                height: 50,
              ),
              padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            ),
            Expanded(
              child: Align(
                child: ClipPath(
                  child: Container(
                    color: Colors.white,
                    height: 300,
                  ),
                  clipper: BottomWaveClipper(),
                ),
                alignment: Alignment.bottomCenter,
              ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ));
  }
}
