import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsPage extends StatefulWidget {
  ContactsPage({Key key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> _contacts;

  @override
  void initState() {
    super.initState();
    _askPermissions();
    refreshContacts();
  }

  Future<void> refreshContacts() async {
    // Load without thumbnails initially.
    var contacts =
        (await ContactsService.getContacts(withThumbnails: false)).toList();
//      var contacts = (await ContactsService.getContactsForPhone("8554964652"))
//          .toList();
    setState(() {
      _contacts = contacts;
    });

    // Lazy load thumbnails after rendering initial contacts.
    for (final contact in contacts) {
      ContactsService.getAvatar(contact).then((avatar) {
        if (avatar == null) return; // Don't redraw if no change.
        setState(() => contact.avatar = avatar);
      });
    }
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus != PermissionStatus.granted) {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.disabled) {
      Map<PermissionGroup, PermissionStatus> permissionStatus =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.contacts]);
      return permissionStatus[PermissionGroup.contacts] ??
          PermissionStatus.unknown;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to location data denied",
          details: null);
    } else if (permissionStatus == PermissionStatus.disabled) {
      throw PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }

  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          _contacts != null
              ? ListView.builder(
                  itemCount: _contacts?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    Contact c = _contacts?.elementAt(index);
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {},
                        ));
                      },
                      leading: (c.avatar != null && c.avatar.length > 0)
                          ? CircleAvatar(backgroundImage: MemoryImage(c.avatar))
                          : CircleAvatar(child: Text(c.initials())),
                      title: Text(c.displayName ?? ""),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }
}
