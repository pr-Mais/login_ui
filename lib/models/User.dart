class User {
  final int userID;
  final String name;
  final String mobileNumber;
  final String password;
  final String emailID;
  final int homeLocationID;
  User(
      {this.userID,
      this.name,
      this.mobileNumber,
      this.emailID,
      this.password,
      this.homeLocationID});

  factory User.fromJson(Map<String, dynamic> json) => User(
        userID: json['userID'],
        name: json['name'],
        mobileNumber: json['mobileNumber'],
        password: json['password'],
        homeLocationID: json['homeLocationID'],
      );

  Map<String, dynamic> toJson() => {
        "userID": userID,
        "name": name,
        "mobileNumber": mobileNumber,
        "password": password,
        "homeLocationID": homeLocationID,
      };
}
