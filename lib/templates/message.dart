class Message{
  String id;
  String? senderName;
  String text;
  String msgType;
  DateTime date;
  bool isSentByClient;
  Message({
    required this.id,
    this.senderName,
    required this.text,
    required this.msgType,
    required this.date,
    required this.isSentByClient,
  });
}