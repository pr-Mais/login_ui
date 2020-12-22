import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:login_ui/services/DatabaseService.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class MessageService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  StreamSubscription iosSubscription;
  void init({BuildContext context}) {
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) async {
        print(data);
        DatabaseService(uid: auth.FirebaseAuth.instance.currentUser.uid)
            .saveDeviceToken(_fcm);
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    } else {
      DatabaseService(uid: auth.FirebaseAuth.instance.currentUser.uid)
          .saveDeviceToken(_fcm);
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.amber,
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );
  }

  sendMessage() {
    var deviceToken =
        'dNypPHPiTiOPJVA1wHbpHQ:APA91bEkzy7JgguX0zvzTgXIAPr6wHf96MSDdQW75znqbLgbaXUSoC5UWQdrjDAVYOhPFwOb7syrd5_eVZTQvdEhomVRAh8quxrSZIrU8Zln-MSgnO5lHBikfsufFXx2sXQbAQT07zto';

    http.post("https://fcm.googleapis.com/fcm/send",
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=' +
              'AAAAF5hTmw0:APA91bFCWXezQDKlKwfd1xFHpnWQoIzlrves0WtSpcYyN2kpz2GQzccL670-UEmU6Y1dc3WF7zkGX4r1EZHpe0Jy2O-k34ZjR91w9ivmRdBOa04ksCoOAs40zeZ5-abvhDbZAU_B9PcJ',
        },
        body: jsonEncode({
          'notification': {
            'title': 'Alert',
            'body': 'Your Friend is in danger Please contact them!!!'
          },
          'to': deviceToken,
          'priority': 'high',
          //  'data': dataPayLoad,
        }));
  }
}
