import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:login_ui/HomePage.dart';
import 'package:path/path.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'main.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class CameraScreen extends StatefulWidget {
  static List<String> files = [];
  @override
  _CameraScreenState createState() {
    return new _CameraScreenState();
  }
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController controller;
  bool _isRecording = false; // Bandera indicadora de grabación en proceso
  String _filePath;
  int endTime = DateTime.now().millisecondsSinceEpoch + (2) * 60 * 60;
  CountdownTimerController _timerController;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    controller = new CameraController(cameras[0], ResolutionPreset.medium);
    _timerController = new CountdownTimerController(
        endTime: endTime,
        onEnd: () {
          _onStop();
          UrlLauncher.launch("tel://9160065588");
          Navigator.push(_globalKey.currentContext,
              MaterialPageRoute(builder: (context) => HomePage()));
        });

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _isRecording = true;
      _onRecord();
      setState(() {});
    });
  }

  void _onPlay() => OpenFile.open(_filePath);

  Future<void> _onStop() async {
    await controller.stopVideoRecording();
    CameraScreen.files.add(_filePath);
    print(CameraScreen.files[0]);
    setState(() => _isRecording = false);
    // dispose();
  }

  Future<void> _onRecord() async {
    var directory = await getTemporaryDirectory();
    _filePath = directory.path + '/${DateTime.now()}.mp4';
    controller.startVideoRecording(_filePath);
    setState(() => _isRecording = true);
  }

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
        key: _globalKey,
        body: Stack(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                child: new CameraPreview(controller)),
            Align(
              alignment: Alignment.bottomCenter,
              child: CountdownTimer(
                controller: _timerController,
                widgetBuilder: (_, CurrentRemainingTime time) {
                  return Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                          color: Color(0xffED553b), shape: BoxShape.circle),
                      child: Center(
                          child: Text(time != null ? '${time.sec}' : '0',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                // color: Colors.black,
                                fontFamily: 'Montserrat',
                              ))));
                },
              ),
            )
          ],
        ));
  }
}
