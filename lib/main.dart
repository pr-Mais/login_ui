import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_ui/HomePage.dart';
import 'package:login_ui/services/AuthenticationService.dart';
import 'package:login_ui/services/MessageService.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
          ),
          Provider<MessageService>(
            create: (_) => MessageService(),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              hintColor: Color(0xFFC0F0E8),
              primaryColor: Color(0xFF80E1D1),
              fontFamily: "Montserrat",
              canvasColor: Colors.transparent),
          home: AuthenticationWrapper(),
        ));
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provider.of<MessageService>(context, listen: false).init(context: context);
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) return HomePage();
    return Home();
    throw UnimplementedError();
  }
}
