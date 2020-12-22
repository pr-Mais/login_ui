import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:login_ui/CameraScreen.dart';
import 'package:login_ui/HomePage.dart';
import 'package:path/path.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'main.dart';

List<String> files = [];

class MyAlerts extends StatefulWidget {
  @override
  _MyAlertsState createState() {
    return new _MyAlertsState();
  }
}

class _MyAlertsState extends State<MyAlerts> {
  CameraController controller; // Bandera indicadora de grabación en proceso
  String _filePath;

  @override
  void initState() {
    super.initState();
    controller = new CameraController(cameras[0], ResolutionPreset.medium);

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      print(CameraScreen.files[0]);
      print("hello");
      // _onPlay(CameraScreen.files[0]);
      setState(() {});
    });
  }

  void _onPlay(String path) => OpenFile.open(path);

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return new Container();
    }
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
            alignment: Alignment.center, child: new CameraPreview(controller)),
      ],
    ));
  }
}
