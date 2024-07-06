import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/sidebar.dart';
import 'package:unimatch/views/mobile/activity.dart';
import 'package:unimatch/views/mobile/friend.dart';
import 'package:unimatch/views/mobile/like.dart';
import 'package:unimatch/views/mobile/home.dart';
import 'package:unimatch/views/mobile/message.dart';

import '../../prefabs/dialogReminder.dart';
import '../../userPreferences.dart';
import '../../webSocket.dart';

class PrimaryPage extends StatefulWidget {
  const PrimaryPage({Key? key}) : super(key: key);

  @override
  State<PrimaryPage> createState() => _PrimaryPageState();
}

class _PrimaryPageState extends State<PrimaryPage> {
  int selectedIndex = 0;
  late Widget w, icon;
  Color bgColor = Colors.white;
  Color backColor = appBarTextColor;
  List<Widget> pages = [const HomeView(), const ActivityView(), const LikeView(), const MessageView()];
  late List<Widget> actions;
  final CardSwiperController controller = CardSwiperController();
  //final cards = candidates.map((candidate) => MatchedUserCard(candidate)).toList();
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    client.activate();
    super.initState();
    w = pages[selectedIndex];
    icon = IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/discoverySetting');
        },
        icon: Icon(Icons.tune, color: appBarTextColor)
    );
    actions = [
      // HomeView
      IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/discoverySetting');
          },
          icon: Icon(Icons.tune, color: appBarTextColor)
      ),
      // ActivityView
      // Row(
      //   children: [
      //     IconButton(
      //         onPressed: () {
      //           // do sth
      //         },
      //         icon: Icon(Icons.filter_list_alt, color: appBarTextColor)),
      //     IconButton(
      //         onPressed: () {
      //           // do sth
      //         },
      //         icon: Icon(Icons.expand_more, color: appBarTextColor)),
      //   ],
      // ),
      const SizedBox(),
      // FollowerView
      const SizedBox(),
      // MessageView
      Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.push (
                  context,
                  MaterialPageRoute (
                    builder: (BuildContext context) => const FriendPage(),
                  ),
                );
              },
              icon: const Icon(Icons.people, color: Colors.white)),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      drawer: const Sidebar(),
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: Image.asset(
          'lib/images/logo.png',
          fit: BoxFit.contain,
          height: 40,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            key.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu, color: backColor),
        ),
        actions: [icon],
      ),
      bottomNavigationBar: GNav(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        backgroundColor: Colors.white,
        color: Colors.black26,
        activeColor: Colors.indigo,
        padding: const EdgeInsets.all(16),
        tabs: const [
          GButton(
            icon: Icons.style,
          ),
          GButton(
            icon: Icons.wine_bar,
          ),
          GButton(
            icon: Icons.auto_awesome,
          ),
          GButton(
            icon: Icons.textsms,
          ),
        ],
        selectedIndex: selectedIndex,
        onTabChange: (index) => setState(() => changePage(index)),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(0),
          child: w,
        ),
      ),
    );
  }

  void changePage(int index) {
    w = pages[index];
    icon = actions[index];
    if (index == 3) {
      bgColor = Colors.indigo.shade600;
      backColor = Colors.white;
      if (UserPreferences.getChatSafely() == null) {
        showDialog(
          context: context,
          builder: (context) => const DialogReminder(),
        );
        UserPreferences.setChatSafely(true);
      }
    } else {
      bgColor = Colors.white;
      backColor = appBarTextColor;
    }
  }

  @override
  void dispose() {
    client.deactivate();
    super.dispose();
  }
}
