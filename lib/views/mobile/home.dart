import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:unimatch/config.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/fn.dart';
import 'package:unimatch/prefabs/tutBasic.dart';
import 'package:unimatch/prefabs/matchedUserCard.dart';
import 'package:unimatch/templates/matchedUser.dart';

import '../../userPreferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<TargetFocus> targets = [];
  GlobalKey keyPrevious = GlobalKey();
  GlobalKey keyNope = GlobalKey();
  GlobalKey keySuperLike = GlobalKey();
  GlobalKey keyLike = GlobalKey();
  GlobalKey keyBoost = GlobalKey();
  bool showResult = false;
  RxInt numCards = 0.obs;

  final CardSwiperController controller = CardSwiperController();

  @override
  void initState() {
    createTutorial(createTargets());
    getResult();
    super.initState();
  }

  getResult() async {
    await getAllUsers();
    if (matchedUsers.isNotEmpty) {
      numCards.value = matchedUsers.length;
      setState(() {
        showResult = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Column(
            children: [
              Flexible(
                child: Obx(() => numCards.value >= 1 ? CardSwiper(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    controller: controller,
                    cardsCount: numCards.value,
                    numberOfCardsDisplayed: 1,
                    backCardOffset: const Offset(0, 30),
                    cardBuilder: (context, index, horizontalThresholdPercentage, verticalThresholdPercentage) {
                      return matchedUserCards[index];
                    },
                    onSwipe: (prev, cur, direction) {
                      if (direction == CardSwiperDirection.right) {
                        // Like
                        likeUser(context, matchedUsers[prev].id);
                        List<String> s = [];
                        if (UserPreferences.getBanId() != null) {
                          s.addAll(UserPreferences.getBanId()!);
                        }
                        if (!s.contains(matchedUsers[prev].id)) {
                          s.add(matchedUsers[prev].id);
                          UserPreferences.setBanId(s);
                        }
                        numCards.value--;
                      } else if (direction == CardSwiperDirection.left) {
                        // Nope
                        List<String> s = [];
                        if (UserPreferences.getBanId() != null) {
                          s.addAll(UserPreferences.getBanId()!);
                        }
                        if (!s.contains(matchedUsers[prev].id)) {
                          s.add(matchedUsers[prev].id);
                          UserPreferences.setBanId(s);
                        }
                        numCards.value--;
                      }
                      // List<String> s = [];
                      // if (UserPreferences.getBanId() != null) {
                      //   s.addAll(UserPreferences.getBanId()!);
                      // }
                      // if (!s.contains(matchedUsers[prev].id)) {
                      //   s.add(matchedUsers[prev].id);
                      //   UserPreferences.setBanId(s);
                      // }
                      // numCards.value--;
                      return true;
                    }
                ) : Center(child: Text("No one has been matched yet!\nPlease come back to UniMatch later!", style: TextStyle(color: Colors.indigo.shade600),)),
              ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    key: keyPrevious,
                    heroTag: "btnPrevious",
                    backgroundColor: Colors.grey,
                    onPressed: controller.undo,
                    mini: true,
                    child: const Icon(Icons.restore),
                  ),
                  FloatingActionButton(
                    key: keyLike,
                    heroTag: "btnLike",
                    backgroundColor: Colors.green,
                    onPressed: controller.swipeRight,
                    child: const Icon(Icons.favorite),
                  ),
                  FloatingActionButton(
                    key: keyNope,
                    heroTag: "btnNope",
                    backgroundColor: Colors.red,
                    onPressed: controller.swipeLeft,
                    mini: true,
                    child: const Icon(Icons.close),
                  ),
                  // FloatingActionButton(
                  //   key: keySuperLike,
                  //   heroTag: "btnSuperLike",
                  //   backgroundColor: Colors.blue,
                  //   onPressed: controller.swipeTop,
                  //   mini: true,
                  //   child: const Icon(Icons.star),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<TargetFocus> createTargets() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        keyTarget: keyPrevious,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return const TutBasic(
                title: "Rematch previous peer!",
                prefixIcon: Icons.restore,
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        keyTarget: keyLike,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return const TutBasic(
                title: "Like current peer!",
                prefixIcon: Icons.favorite,
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        keyTarget: keyNope,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return const TutBasic(
                title: "Skip current peer!",
                prefixIcon: Icons.close,
              );
            },
          ),
        ],
      ),
    );
    // targets.add(
    //   TargetFocus(
    //     keyTarget: keySuperLike,
    //     alignSkip: Alignment.topRight,
    //     enableOverlayTab: true,
    //     contents: [
    //       TargetContent(
    //         align: ContentAlign.top,
    //         builder: (context, controller) {
    //           return const TutBasic(
    //             title: "SUPER-LIKE current peer!",
    //             prefixIcon: Icons.star,
    //           );
    //         },
    //       ),
    //     ],
    //   ),
    // );
    return targets;
  }
}
