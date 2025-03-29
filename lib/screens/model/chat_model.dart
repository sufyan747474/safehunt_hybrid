class ChatModel {
  String? id;
  String? senderId;
  String? receiverId;
  String? message;
  String? createdAt;
  String? attachment;

  ChatModel({
    this.id,
    this.senderId,
    this.receiverId,
    this.message,
    this.createdAt,
    this.attachment,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json["id"].toString(),
        senderId: json["senderId"].toString(),
        receiverId: json["receiverId"].toString(),
        message: json["message"],
        createdAt: json["createdAt"],
        attachment: json["attachment"],
      );
}
