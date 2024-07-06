import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unimatch/config.dart';
import 'package:unimatch/fn.dart';
import 'package:unimatch/views/mobile/setting.dart';
import 'package:unimatch/views/mobile/feedback.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});
  @override
  Widget build(BuildContext context) {
    const itemColor = Colors.indigo;
    const gap = 8.0;
    var width = MediaQuery.of(context).size.width * 0.6;
    return Drawer(
      backgroundColor: Colors.white,
      width: width,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            margin: EdgeInsets.zero,
            accountName: Text(clientUser.nickname),
            accountEmail: Text(clientUser.email),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/profile");
                  },
                  child: CachedNetworkImage(
                    // fit: BoxFit.fitWidth,
                    imageUrl: clientUser.avatar,
                    width: MediaQuery.of(context).size.width * 0.5,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.indigo.shade600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "/profile");
                    },
                    title: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.account_circle,
                          color: itemColor,
                        ),
                        SizedBox(width: gap,),
                        Text(
                          "Profile",
                          style: TextStyle(fontSize: 16, color: itemColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                ),
                ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "/verify");
                    },
                    title: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.portrait,
                          color: itemColor,
                        ),
                        SizedBox(width: gap,),
                        Text(
                          "Verification",
                          style: TextStyle(fontSize: 16, color: itemColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                ),
                ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "/setting");
                    },
                    title: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.settings,
                          color: itemColor,
                        ),
                        SizedBox(width: gap,),
                        Text(
                          "Settings",
                          style: TextStyle(fontSize: 16, color: itemColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                ),
                ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "/feedback");
                    },
                    title: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.contact_support,
                          color: itemColor,
                        ),
                        SizedBox(width: gap,),
                        Text(
                          "Feedback",
                          style: TextStyle(fontSize: 16, color: itemColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                ),
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      isLogged.value = false;
                      clientUser.username = "";
                      clientUser.email = "";
                      Navigator.pushReplacementNamed(context, "/landing");
                      showMsg(context, "Logout Successfully!", Colors.green);
                    },
                    title: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.logout,
                          color: itemColor,
                        ),
                        SizedBox(width: gap,),
                        Text(
                          "Logout",
                          style: TextStyle(fontSize: 16, color: itemColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
