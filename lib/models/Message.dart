class Message {
  final int messageID;
  final String text;
  final int contactID;
  final String videoLink;
  final String audioLink;
  final int locationID;
  Message(
      {this.messageID,
      this.text,
      this.contactID,
      this.videoLink,
      this.audioLink,
      this.locationID});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        messageID: json['messageID'],
        text: json['text'],
        contactID: json['contactID'],
        videoLink: json['videoLink'],
        audioLink: json['audioLink'],
        locationID: json['locationID'],
      );

  Map<String, dynamic> toJson() => {
        "messageID": messageID,
        "text": text,
        "contactID": contactID,
        "audioLink": audioLink,
        "videoLink": videoLink,
        "locationID": locationID,
      };
}
