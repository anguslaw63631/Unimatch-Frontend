import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unimatch/fn.dart';
import 'package:unimatch/prefabs/likedUserList.dart';
import 'package:unimatch/templates/likedUser.dart';

import '../../webSocket.dart';

class LikeView extends StatefulWidget {
  const LikeView({Key? key}) : super(key: key);

  @override
  State<LikeView> createState() => _LikeViewState();
}

class _LikeViewState extends State<LikeView> with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    subInvitation(refresh);
    super.initState();
    controller = TabController(length: 1, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TabBar(
              labelColor: Colors.indigo.shade600,
              indicatorColor: Colors.indigoAccent,
              controller: controller,
              tabs: const [
                Tab(text: "Likes",),
                // Tab(text: "SUPER-LIKES",)
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: <Widget>[
                  FutureBuilder(
                    future: getLikedUserList(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length > 0) {
                            return SingleChildScrollView(
                              child: GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: MediaQuery.of(context).size.height * 0.35,
                                ),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return LikedUserList(
                                    id: snapshot.data[index].id,
                                    userId: snapshot.data[index].userId,
                                    userNickname: snapshot.data[index].userNickname,
                                    userAvatar: snapshot.data[index].userAvatar,
                                    createTime: snapshot.data[index].createTime,
                                    remark: snapshot.data[index].remark,
                                    status: snapshot.data[index].status,
                                    notifyParent: refresh,
                                  );
                                },
                              ),
                            );
                          }
                        }
                      } else if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return const Center(child: Text("You Don't Have Any Like Yet!", textAlign: TextAlign.center, style: TextStyle(color: Colors.black),));
                    },
                  ),
                  // const Center(child: Text("Constructing...", textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void refresh() {setState(() {});}
}

// Expanded(
//   child: SingleChildScrollView(
//     child: GridView.builder(
// //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //           crossAxisCount: 2,
// //           mainAxisExtent: 256,
// //       ),
// //       shrinkWrap: true,
// //       physics: const NeverScrollableScrollPhysics(),
// //       itemCount: 5,
// //       itemBuilder: (context, index) {
// //         return FollowerList(
// //             img: followers[index].img,
// //             name: followers[index].name,
// //             age: followers[index].age,
// //             location: followers[index].location);
// //       },
// //     ),
//   ),
// ),
