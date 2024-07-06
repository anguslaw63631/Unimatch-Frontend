import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:unimatch/bleController.dart';
import 'package:unimatch/config.dart';
import 'package:unimatch/fn.dart';
import 'package:unimatch/prefabs/abBasic.dart';
import 'package:unimatch/prefabs/locationUserList.dart';
import 'package:unimatch/templates/LocationUser.dart';

import '../../const.dart';

class PeopleNearbyPage extends StatefulWidget {
  const PeopleNearbyPage({Key? key}) : super(key: key);

  @override
  State<PeopleNearbyPage> createState() => _PeopleNearbyPageState();
}

class _PeopleNearbyPageState extends State<PeopleNearbyPage> {
  @override
  Widget build(BuildContext context) {
    BleController bleController = BleController();
    return Scaffold(
      appBar: AppbarBasic(
        appBar: AppBar(),
        title: "People Nearby",
        enableActions: true,
        onTap: () {
          Navigator.pop(context);
          // Reset User Location Code
        },
        actions: [
          IconButton(onPressed: () async {
            bleController.rescan();
          }, icon: Icon(Icons.search, color: appBarTextColor,)),
        ],
      ),
      body: GetBuilder<BleController>(
        init: bleController,
        builder: (BleController controller) {
          controller.scanDevices();
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StreamBuilder<List<ScanResult>>(
                    stream: controller.scanResults,
                    builder: (context, snapshots) {
                      if (snapshots.hasData) {
                        if (snapshots.data!.isNotEmpty) {
                          List<ScanResult> beacons = snapshots.data!;
                          for (int i = 0; i < snapshots.data!.length; i++) {
                            if (BEACON_ID.contains(beacons[i].device.remoteId.str)) {
                              var location = (BEACON_ID.indexOf(beacons[i].device.remoteId.str) + 1).toString();
                              var distance = rssi2Distance(beacons[i].rssi);
                              controller.stopScan();
                              return Expanded(
                                child: FutureBuilder(
                                  future: getLocationUsers(location, distance),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data.length > 0) {
                                          return SingleChildScrollView(
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemCount: locationMatchedUsers.length,
                                              itemBuilder: (context, index) {
                                                return LocationUserList(
                                                  locationUser: LocationUser(
                                                      id: locationMatchedUsers[index].id,
                                                      avatar: locationMatchedUsers[index].avatar,
                                                      username: locationMatchedUsers[index].username,
                                                      nickname: locationMatchedUsers[index].nickname,
                                                      email: locationMatchedUsers[index].email,
                                                      sex: locationMatchedUsers[index].sex,
                                                      birthday: locationMatchedUsers[index].birthday,
                                                      interest1: locationMatchedUsers[index].interest1,
                                                      interest2: locationMatchedUsers[index].interest2,
                                                      interest3: locationMatchedUsers[index].interest3,
                                                      major: locationMatchedUsers[index].major,
                                                      intro: locationMatchedUsers[index].intro,
                                                      createTime: locationMatchedUsers[index].createTime,
                                                      updateTime: locationMatchedUsers[index].updateTime,
                                                      distance: locationMatchedUsers[index].distance
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        }
                                      }
                                    } else if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Center(child: CircularProgressIndicator());
                                    }
                                    return Center(child: Text("Beacon Found! Nobody Found Nearby!", textAlign: TextAlign.center, style: TextStyle(color: Colors.indigo.shade600),));
                                  },
                                ),
                              );
                              return Center(child: Text("Location Found!", style: TextStyle(color: Colors.indigo.shade600),));
                              // return ListTile(
                              //   title: Text(data.device.platformName),
                              //   subtitle: Text(data.device.remoteId.str),
                              //   trailing: Text(data.rssi.toString()),
                              // );
                            }
                          }
                        } else {
                          // return const SizedBox.shrink();
                          return Center(child: Text("No Beacon Found!", style: TextStyle(color: Colors.indigo.shade600),));
                        }
                      }
                      return Center(child: Text("Scanning Nearby Beacons...", style: TextStyle(color: Colors.indigo.shade600),));
                    }
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    locationMatchedUsers.clear();
    updateUserLocation("0");
    super.dispose();
  }
}
