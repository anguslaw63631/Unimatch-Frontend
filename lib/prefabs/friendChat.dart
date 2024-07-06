import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:unimatch/config.dart';
import 'package:unimatch/fn.dart';
import 'package:unimatch/prefabs/abBasic.dart';
import 'package:unimatch/templates/Message.dart';
import 'package:unimatch/templates/chatFriend.dart';
import 'package:unimatch/templates/matchedUser.dart';
import 'package:unimatch/webSocket.dart';
import '../views/profile/userProfile.dart';


class FriendChatPage extends StatefulWidget {
  const FriendChatPage({
    super.key,
    required this.toUser,
    required this.notifyParent
  });

  final Function() notifyParent;
  final ChatFriend toUser;

  @override
  State<FriendChatPage> createState() => _FriendChatPageState();
}

class _FriendChatPageState extends State<FriendChatPage> {
  TextEditingController teSend = TextEditingController();
  
  @override
  void initState() {
    subFriend(refreshSelf);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade200,
      appBar: AppbarBasic(
        appBar: AppBar(),
        title: widget.toUser.toUserName,
        bgColor: Colors.indigo.shade600,
        color: Colors.white,
        enableActions: true,
        onTap: () {
          Navigator.pop(context);
          widget.notifyParent();
        },
        actions: [
          IconButton(onPressed: () async {
            MatchedUser u = await getUserDetailById(widget.toUser.toUserId == clientUser.id ? widget.toUser.fromUserId : widget.toUser.toUserId);
            if (context.mounted) {
              Navigator.push (
                context,
                MaterialPageRoute (
                  builder: (BuildContext context) => UserProfilePage(
                    matchedUser: MatchedUser(
                        id: u.id,
                        avatar: u.avatar,
                        username: u.username,
                        nickname: u.nickname,
                        email: u.email,
                        sex: u.sex,
                        birthday: u.birthday,
                        interest1: u.interest1,
                        interest2: u.interest2,
                        interest3: u.interest3,
                        last_location: u.last_location,
                        major: u.major,
                        intro: u.intro,
                        createTime: u.createTime,
                        updateTime: u.updateTime),
                    isFriend: true,
                    notifyParent: refresh,
                  ),
                ),
              );
            }
          }, icon: const Icon(Icons.more_horiz, color: Colors.white,)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder(
                      future: getFriendMsgList(clientUser.id, widget.toUser.toUserId == clientUser.id ? widget.toUser.fromUserId : widget.toUser.toUserId),
                      builder: (context, snapshot) {
                        return GroupedListView<Message, DateTime>(
                          padding: const EdgeInsets.all(8),
                          reverse: true,
                          order: GroupedListOrder.DESC,
                          useStickyGroupSeparators: true,
                          floatingHeader: true,
                          elements: friendMessages,
                          groupBy: (message) => DateTime(
                            message.date.year,
                            message.date.month,
                            message.date.day,
                          ),
                          groupHeaderBuilder: (Message message) => SizedBox(
                            height: 40,
                            child: Center(
                              child: Card(
                                surfaceTintColor: Colors.transparent,
                                color: Colors.indigo,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    DateFormat.yMMMd().format(message.date),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          itemBuilder: (context, Message message) =>
                              Align(
                                alignment: message.isSentByClient ? Alignment.centerRight : Alignment.centerLeft,
                                child: GestureDetector(
                                  onLongPress: () {
                                    if (message.isSentByClient != false) {
                                      showUpdateMsgStatusDialog(context, message.id);
                                    }
                                  },
                                  child: Card(
                                    surfaceTintColor: Colors.transparent,
                                    color: message.isSentByClient ? Colors.white : Colors.blueAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      child: IntrinsicWidth(
                                        child: ListTile(
                                            contentPadding: const EdgeInsets.all(0),
                                            horizontalTitleGap: 8,
                                            visualDensity: const VisualDensity(vertical: -4),
                                            title: message.msgType == "2" ? CachedNetworkImage(
                                              imageUrl: message.text,
                                              fit: BoxFit.fitWidth,
                                              width: MediaQuery.of(context).size.width * 0.55,
                                              progressIndicatorBuilder:
                                                  (context, url, downloadProgress) => Center(
                                                child: CircularProgressIndicator(
                                                    value: downloadProgress.progress),
                                              ),
                                              errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                            ) : Text(message.text),
                                            titleTextStyle: TextStyle(color: message.isSentByClient ? Colors.black : Colors.white, fontSize: 16),
                                            subtitleTextStyle: TextStyle(color: message.isSentByClient ? Colors.black : Colors.white, fontSize: 8),
                                            subtitle: Row(
                                              children: [
                                                Expanded(child: Container()),
                                                Text("${message.date.hour < 10 ? "0${message.date.hour}" : message.date.hour}:${message.date.minute < 10 ? "0${message.date.minute}" : message.date.minute} ${message.date.hour <= 12 ? "AM" : "PM"}"),
                                              ],
                                            ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        );
                      },
                )
            ),
            pendingSendImg == null ?
            TextField(
              controller: teSend,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade300,
                contentPadding: const EdgeInsets.all(12),
                prefixIcon: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => buildBottomSheet(context, refreshSelf));
                  },
                  child: Icon(pendingSendImg == null ? Icons.add : Icons.close, color: Colors.indigo.shade600)
                ),
                suffixIcon: GestureDetector(
                    onTap: () {
                      sendMsg();
                    },
                    child: Icon(Icons.send, color: Colors.indigo.shade600),
                ),
              ),
            ) :
            Container(
              color: Colors.grey.shade300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {
                    setState(() {
                      pendingSendImg = null;
                    });
                  }, icon: const Icon(Icons.close), color: Colors.indigo.shade600),
                  Flexible(
                    child: Image.file(
                      pendingSendImg!,
                    ),
                  ),
                  IconButton(onPressed: () {
                    sendImg();
                  }, icon: const Icon(Icons.send), color: Colors.indigo.shade600),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }

  Future<void> sendMsg() async {
    if (teSend.text.isNotEmpty) {
      await sendFriendMsg(clientUser.id, widget.toUser.toUserId == clientUser.id ? widget.toUser.fromUserId : widget.toUser.toUserId, teSend.text, "1");
      teSend.clear();
      setState(() {});
    }
  }

  Future<void> sendImg() async {
    String url = await uploadFile(2, pendingSendImg!);
    await sendFriendMsg(clientUser.id, widget.toUser.toUserId == clientUser.id ? widget.toUser.fromUserId : widget.toUser.toUserId, url, "2");
    pendingSendImg = null;
    teSend.clear();
    setState(() {});
  }

  showUpdateMsgStatusDialog(BuildContext context, String msgId) {
    return showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          title: const Center(
            child: Text("Notice", style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          content: const Text("Are you sure to revoke or delete this message?"),
          actions: [
            TextButton(onPressed: () {Navigator.pop(context);}, child: const Text("Cancel")),
            TextButton(onPressed: () async {
              Navigator.pop(context);
              await updateFriendMsgStatus(context, msgId, "1");
              setState(() {});
              }, child: const Text("Revoke")),
            TextButton(onPressed: () async {
              Navigator.pop(context);
              await updateFriendMsgStatus(context, msgId, "2");
              setState(() {});
              }, child: const Text("Delete")),
          ],
        );
      },
    );
  }

  refresh() {
    widget.notifyParent();
  }

  refreshSelf() {
    setState(() {});
  }

  @override
  void dispose() {
    pendingSendImg = null;
    friendMessages.clear();
    super.dispose();
  }
}
