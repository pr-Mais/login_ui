class Securer {
  final int securerID;
  final int messageID;
  final bool hasRecieved;
  Securer({
    this.securerID,
    this.messageID,
    this.hasRecieved,
  });

  factory Securer.fromJson(Map<String, dynamic> json) => Securer(
        securerID: json['securerID'],
        messageID: json['messageID'],
        hasRecieved: json['hasRecieved'],
      );

  Map<String, dynamic> toJson() => {
        "securerID": securerID,
        "messageID": messageID,
        "hasRecieved": hasRecieved,
      };
}
