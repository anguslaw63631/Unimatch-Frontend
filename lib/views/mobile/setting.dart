import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/prefabs/abBasic.dart';

import '../../components/btnFlexible.dart';
import '../../config.dart';
import '../../fn.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  RxBool isPublicVisible = true.obs;
  final itemColor = Colors.indigo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
      AppbarBasic(
          appBar: AppBar(),
          title: "Settings",
          bgColor: Colors.grey.shade100,
          onTap: () {Navigator.of(context).pop();}
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView(
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: itemColor,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Account",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: itemColor),
                ),
              ],
            ),
            Divider(
              color: itemColor,
              height: 15,
              thickness: 4,
            ),
            const SizedBox(
              height: 10,
            ),
            buildPageOption("Change Password", () {Navigator.pushNamed(context, "/resetPwd");}),
            // Obx(() => buildSwitchOption("Global Visibility", () {}, isPublicVisible)),
            const SizedBox(
              height: 40,
            ),
            const SizedBox(
              height: 25,
            ),
            Image.asset(
              'lib/images/logo.png',
              fit: BoxFit.contain,
              height: 75,
            ),
            Center(
                child: Column(
                  children: [
                    Text(PACKAGEINFO.appName, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                    Text(PACKAGEINFO.packageName, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                    Text("Version ${PACKAGEINFO.version} (${PACKAGEINFO.buildNumber})", style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  ],
                )),
            const SizedBox(
              height: 25,
            ),
            BtnFlexible(
              name: "Logout",
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                isLogged.value = false;
                clientUser.username = "";
                clientUser.email = "";
                Navigator.pushReplacementNamed(context, "/landing");
                showMsg(context, "Logout Successfully!", Colors.green);
              },
            ),
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: itemColor),
        ),
        Transform.scale(
          scale: 0.7,
        )
      ],
    );
  }

  Widget buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Option 1"),
                    Text("Option 2"),
                    Text("Option 3"),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: itemColor,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: itemColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPageOption(String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: itemColor,
              ),
            ),
            Icon(
              Icons.navigate_next,
              color: itemColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSwitchOption(String title, Function() onTap, RxBool status) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: itemColor,
              ),
            ),
            Switch(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: Colors.indigo,
                inactiveTrackColor: Colors.white,
                value: status.value,
                onChanged: (value) {
                  status.value = value;
                }),
          ],
        ),
      ),
    );
  }
}
