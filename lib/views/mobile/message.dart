import 'package:flutter/material.dart';
import 'package:unimatch/fn.dart';
import 'package:unimatch/prefabs/chatFriendList.dart';
import 'package:unimatch/views/group/addGroup.dart';

class MessageView extends StatefulWidget {
  const MessageView({Key? key}) : super(key: key);

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => AddGroupPage(notifyParent: refresh),
            ),
          );
        },
        label: const Row(
          children: [
            Icon(Icons.add, color: Colors.indigo,),
            Text(style: TextStyle(color: Colors.indigo),'Add Group'),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: getConversationList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length > 0) {
                      return Expanded(
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return ChatFriendList(
                                lastMsg: snapshot.data[index].lastMsg,
                                lastTime: snapshot.data[index].lastTime,
                                msgType: snapshot.data[index].msgType,
                                fromUserId: snapshot.data[index].fromUserId,
                                toUserId: snapshot.data[index].toUserId,
                                toUserName: snapshot.data[index].toUserName,
                                toUserAvatar: snapshot.data[index].toUserAvatar,
                                toUserNickname: snapshot.data[index].toUserNickname,
                                unread: snapshot.data[index].unread,
                                status: snapshot.data[index].status,
                                isGroup: snapshot.data[index].isGroup,
                                notifyParent: refresh,
                              );
                            },
                          ),
                        ),
                      );
                    }
                  }
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const Center(child: Text("You Don't Have Any Friends Yet!", textAlign: TextAlign.center, style: TextStyle(color: Colors.black),));
              }
            ),
          ],
        ),
      ),
    );
  }

  refresh() {setState(() {});}
}
