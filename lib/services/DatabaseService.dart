import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future saveDeviceToken(FirebaseMessaging _fcm) async {
    String fcmToken = await _fcm.getToken();
    if (fcmToken != null) {
      var tokens = userCollection.doc(uid).collection('tokens').doc(fcmToken);
      return await tokens.set({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(),
        'platform': Platform.operatingSystem
      });
    }
  }

  Future<List<Contact>> getContact() async {
    List<Contact> selected = [];
    var contacts = await userCollection
        .doc(uid)
        .collection("EmergencyContacts")
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        selected.add(Contact(
            displayName: ds.data()['name'],
            phones: [Item(value: ds.data()['number'])]));
      }
    });
    return selected;
  }

  Future setContact(List<Contact> sContacts) async {
    var contacts = await userCollection
        .doc(uid)
        .collection("EmergencyContacts")
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    var setContacts = userCollection.doc(uid).collection("EmergencyContacts");
    for (int i = 0; i < sContacts.length; i++) {
      await setContacts.add({
        "name": sContacts[i].displayName,
        "number": sContacts[i].phones.first.value,
        "priority": i + 1
      });
    }
  }

  Future updateUserData(String name, String mobileNo, String email) async {
    return await userCollection.doc(uid).set({
      "name": name,
      "mobileNo": mobileNo,
      "email": email,
      "locId": 500072,
      "createdOn": DateTime.now()
    });
  }
}
