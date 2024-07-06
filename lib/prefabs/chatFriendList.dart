import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unimatch/config.dart';
import 'package:unimatch/convertFn.dart';
import 'package:unimatch/fn.dart';
import 'package:unimatch/templates/chatFriend.dart';
import 'package:unimatch/userPreferences.dart';
import 'package:unimatch/prefabs/friendChat.dart';
import 'package:unimatch/prefabs/groupChat.dart';

import '../webSocket.dart';

class ChatFriendList extends StatefulWidget {
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
  ChatFriendList({
    super.key,
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
    required this.isGroup,
    required this.notifyParent,
  });

  final Function() notifyParent;

  @override
  State<ChatFriendList> createState() => _ChatFriendListState();
}

class _ChatFriendListState extends State<ChatFriendList> {
  final textColor = Colors.indigo.shade800;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: GestureDetector(
          onTap: () {
            if (context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                !widget.isGroup ? FriendChatPage(
                  toUser: ChatFriend(
                      lastMsg: widget.lastMsg,
                      lastTime: widget.lastTime,
                      msgType: widget.msgType,
                      fromUserId: widget.fromUserId,
                      toUserId: widget.toUserId,
                      toUserName: widget.toUserName,
                      toUserAvatar: widget.toUserAvatar,
                      toUserNickname: widget.toUserNickname,
                      unread: widget.unread,
                      status: widget.status,
                      isGroup: widget.isGroup
                  ),
                  notifyParent: refresh,
                ) :
                GroupChatPage(
                  toUser: ChatFriend(
                      lastMsg: widget.lastMsg,
                      lastTime: widget.lastTime,
                      msgType: widget.msgType,
                      fromUserId: widget.fromUserId,
                      toUserId: widget.toUserId,
                      toUserName: widget.toUserName,
                      toUserAvatar: widget.toUserAvatar,
                      toUserNickname: widget.toUserNickname,
                      unread: widget.unread,
                      status: widget.status,
                      isGroup: widget.isGroup
                  ),
                  notifyParent: refresh,
                )
                ),
              );
            }
          },
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.toUserAvatar,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const CircleAvatar(
                    backgroundImage: AssetImage("lib/images/noprofile.png"),
                    radius: 30,
                  ),
                ),
                const SizedBox(width: 16,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.toUserName, style: TextStyle(color: textColor,fontSize: 16),),
                    const SizedBox(height: 8,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        widget.lastMsg.contains(".png") || widget.lastMsg.contains(".jpg") ? "Image" : widget.lastMsg,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: TextStyle(color: textColor,fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(formatTime(widget.lastTime), style: TextStyle(color: textColor, fontSize: 12),),
          ],
        ),
      ),
    );
  }

  refresh() {
    widget.notifyParent();
  }
}
