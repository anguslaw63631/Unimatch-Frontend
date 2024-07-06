import 'package:flutter/material.dart';
import 'package:unimatch/config.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/fn.dart';
import 'package:unimatch/prefabs/abBasic.dart';
import 'package:unimatch/prefabs/eventList.dart';
import 'package:unimatch/prefabs/groupList.dart';
import 'package:unimatch/prefabs/singleActivity.dart';
import 'package:unimatch/templates/event.dart';
import 'package:unimatch/templates/group.dart';
import 'package:unimatch/templates/matchedUser.dart';
import 'package:unimatch/views/event/addEvent.dart';

import '../../prefabs/friendList.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({Key? key}) : super(key: key);

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppbarBasic(
        appBar: AppBar(),
        title: "Your Friends",
        onTap: () {Navigator.pop(context);},
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder(
              future: getFriendList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length > 0) {
                      return SingleChildScrollView(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                            return FriendList(
                              friend: snapshot.data[index]
                            );
                          },
                        ),
                      );
                    }
                  }
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const Center(child: Text("You Don't Have Any Friend Yet!", textAlign: TextAlign.center, style: TextStyle(color: Colors.black),));
              },
            ),
          ],
        ),
      ),
    );
  }

  refresh() {setState(() {});}
}


