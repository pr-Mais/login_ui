import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_ui/services/DatabaseService.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class ContactsPage extends StatefulWidget {
  ContactsPage({Key key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> _contacts;
  List<Contact> _selectedContacts = new List<Contact>();

  @override
  void initState() {
    super.initState();
    refreshContacts();
  }

  Future<void> refreshContacts() async {
    var contacts =
        (await ContactsService.getContacts(withThumbnails: false)).toList();
    setState(() {
      _contacts = contacts;
    });
    for (final contact in contacts) {
      ContactsService.getAvatar(contact).then((avatar) {
        if (avatar == null) return;
        setState(() => contact.avatar = avatar);
      });
    }
    _selectedContacts =
        await DatabaseService(uid: auth.FirebaseAuth.instance.currentUser.uid)
            .getContact();
  }

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
            alignment: Alignment.topCenter,
            child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text("Emergency Contacts",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                    )))),
        Padding(
          padding: EdgeInsets.only(top: 100),
          child: Container(
              // height: 250,
              child: _selectedContacts != null
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _selectedContacts?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        Contact c = _selectedContacts?.elementAt(index);
                        return GestureDetector(
                          onTap: () async {
                            _selectedContacts.remove(c);
                            await DatabaseService(
                                    uid: auth
                                        .FirebaseAuth.instance.currentUser.uid)
                                .setContact(_selectedContacts);
                            setState(() {
                              print(_selectedContacts);
                            });
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(children: [
                                (c.avatar != null && c.avatar.length > 0)
                                    ? CircleAvatar(
                                        radius: 30,
                                        backgroundImage: MemoryImage(c.avatar))
                                    : CircleAvatar(
                                        radius: 30, child: Text(c.initials())),
                                Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Text(c.displayName ?? "",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        )))
                              ]),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    )),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0)),
              child: Container(
                height: 550,
                color: Colors.white,
                child: _contacts != null
                    ? ListView.builder(
                        itemCount: _contacts?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          Contact c = _contacts?.elementAt(index);
                          return Column(
                            children: <Widget>[
                              ListTile(
                                onTap: () async {
                                  setState(() {
                                    _selectedContacts.add(c);
                                  });
                                  await DatabaseService(
                                          uid: auth.FirebaseAuth.instance
                                              .currentUser.uid)
                                      .setContact(_selectedContacts);
                                  print(_selectedContacts.length);
                                },
                                leading: (c.avatar != null &&
                                        c.avatar.length > 0)
                                    ? CircleAvatar(
                                        backgroundImage: MemoryImage(c.avatar))
                                    : CircleAvatar(child: Text(c.initials())),
                                title: Text(c.displayName ?? "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                    )),
                              ),
                              Divider(
                                thickness: 1,
                                color: Theme.of(context).primaryColor,
                              )
                            ],
                          );
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ))
      ],
    );
  }
}
