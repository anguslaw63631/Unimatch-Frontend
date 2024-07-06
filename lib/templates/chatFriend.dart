class ChatFriend{
  String lastMsg;
  DateTime lastTime;
  String msgType;
  String fromUserId;
  String toUserId;
  String toUserName;
  String toUserAvatar;
  String toUserNickname;
  String unread;
  String status;
  bool isGroup;
  ChatFriend({
    required this.lastMsg,
    required this.lastTime,
    required this.msgType,
    required this.fromUserId,
    required this.toUserId,
    required this.toUserName,
    required this.toUserAvatar,
    required this.toUserNickname,
    required this.unread,
    required this.status,
    required this.isGroup
  });
}