class ChatMessage {
  String? sender;
  String? body;
  int? sentAt;

  ChatMessage({required this.sender, required this.body, required this.sentAt});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    sender = json['sender'];
    body = json['body'];
    sentAt = json['sentAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sender'] = sender;
    data['body'] = sender;
    data['sentAt'] = sentAt;
    return data;
  }
}
