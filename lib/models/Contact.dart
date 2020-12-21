class Contacts {
  final int contactID;
  final String name;
  final String mobileNumber;
  final String emailID;
  final int locationID;
  Contacts(
      {this.contactID,
      this.name,
      this.mobileNumber,
      this.emailID,
      this.locationID});

  factory Contacts.fromJson(Map<String, dynamic> json) => Contacts(
        contactID: json['contactID'],
        name: json['name'],
        mobileNumber: json['mobileNumber'],
        emailID: json['emailID'],
        locationID: json['locationID'],
      );

  Map<String, dynamic> toJson() => {
        "contactID": contactID,
        "name": name,
        "mobileNumber": mobileNumber,
        "emailID": emailID,
        "locationID": locationID,
      };
}
