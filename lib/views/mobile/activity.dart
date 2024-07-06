import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimatch/config.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/fn.dart';
import 'package:unimatch/prefabs/abBasic.dart';
import 'package:unimatch/prefabs/eventList.dart';
import 'package:unimatch/prefabs/groupList.dart';
import 'package:unimatch/prefabs/singleActivity.dart';
import 'package:unimatch/templates/event.dart';
import 'package:unimatch/templates/group.dart';
import 'package:unimatch/views/event/addEvent.dart';
import 'package:unimatch/views/group/addGroup.dart';

class ActivityView extends StatefulWidget {
  const ActivityView({Key? key}) : super(key: key);
  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> with SingleTickerProviderStateMixin {
  late TabController controller;
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    controller.addListener(() {
      if (controller.indexIsChanging) {
        setState(() {
          currentPage = controller.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      floatingActionButton: currentPage == 0 ? FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push (
            context,
            MaterialPageRoute (
              builder: (BuildContext context) => AddEventPage(notifyParent: refresh,),
            ),
          );
        },
        label: const Row(
          children: [
            Icon(Icons.add, color: Colors.indigo,),
            Text(style: TextStyle(color: Colors.indigo),'Add Event'),
          ],
        ),
      ) : FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push (
            context,
            MaterialPageRoute (
              builder: (BuildContext context) => AddGroupPage(notifyParent: refresh,),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TabBar(
              labelColor: Colors.indigo.shade600,
              indicatorColor: Colors.indigoAccent,
              controller: controller,
              tabs: const [
                Tab(text: "Events",),
                Tab(text: "Groups",)
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: <Widget>[
                  FutureBuilder(
                    future: getEventList(),
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
                                  return EventList(
                                    notifyParent: refresh,
                                    event: SingleEvent(
                                        id: snapshot.data[index].id,
                                        avatar: snapshot.data[index].avatar,
                                        title: snapshot.data[index].title,
                                        notice: snapshot.data[index].notice,
                                        description: snapshot.data[index].description,
                                        type: snapshot.data[index].type,
                                        pplCount: snapshot.data[index].pplCount,
                                        location: snapshot.data[index].location,
                                        time: snapshot.data[index].time
                                    )
                                  );
                                },
                              ),
                            );
                          }
                        }
                      } else if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return const Center(child: Text("No Created Event Yet!", textAlign: TextAlign.center, style: TextStyle(color: Colors.black),));
                    },
                  ),
                  FutureBuilder(
                    future: getGroupList(),
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
                                  return GroupList(
                                      notifyParent: refresh,
                                      group: SingleGroup(
                                          id: snapshot.data[index].id,
                                          avatar: snapshot.data[index].avatar,
                                          title: snapshot.data[index].title,
                                          notice: snapshot.data[index].notice,
                                          description: snapshot.data[index].description,
                                          type: snapshot.data[index].type,
                                          pplCount: snapshot.data[index].pplCount
                                      )
                                  );
                                },
                              ),
                            );
                          }
                        }
                      } else if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return const Center(child: Text("No Created Group Yet!", textAlign: TextAlign.center, style: TextStyle(color: Colors.black),));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    //   child: Column(
    //     children: [
    //       Container(
    //         height: 35,
    //         decoration: BoxDecoration(
    //             color: Colors.indigoAccent,
    //             borderRadius: BorderRadius.circular(12)
    //         ),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             const Padding(
    //               padding: EdgeInsets.symmetric(horizontal: 5),
    //               child: Icon(
    //                 Icons.search,
    //                 color: Colors.white,
    //               ),
    //             ),
    //             Expanded(
    //                 child: TextField(
    //                   onTap: () {
    //                     // Navigator.push(context, MaterialPageRoute(
    //                     //     builder: (context) => const SearchPage()
    //                     // ));
    //                   },
    //                   readOnly: true,
    //                   textAlign: TextAlign.center,
    //                   decoration: const InputDecoration(
    //                     border: InputBorder.none,
    //                   ),
    //                 )),
    //           ],
    //         ),
    //       ),
    //       const Padding(padding: EdgeInsets.only(top: 8)),
    //       Expanded(
    //         child: SingleChildScrollView(
    //           child: ListView.builder(
    //             shrinkWrap: true,
    //             physics: const NeverScrollableScrollPhysics(),
    //             itemCount: 1,
    //             itemBuilder: (context, index) {
    //               return Container();
    //               // return EventList(
    //               //   img: activities[index].img,
    //               //   name: activities[index].name,
    //               //   location: activities[index].location,
    //               //   actTime: activities[index].actTime,
    //               //   desc: activities[index].desc,
    //               //   pplCount: activities[index].pplCount,
    //               //   type: activities[index].type,
    //               //   postTime: activities[index].postTime,
    //               // );
    //             },
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
  }

  refresh() {setState(() {
    currentPage = controller.index;
  });}
}


