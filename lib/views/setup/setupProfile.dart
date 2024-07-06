import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:unimatch/config.dart';
import 'package:unimatch/fn.dart';
import 'package:unimatch/views/setup/birthday.dart';
import 'package:unimatch/views/setup/interest.dart';
import 'package:unimatch/views/setup/intro.dart';
import 'package:unimatch/views/setup/nickname.dart';
import 'package:unimatch/views/setup/gender.dart';
import 'package:unimatch/views/setup/programType.dart';

import '../../components/btnFlexible.dart';
import '../../prefabs/abBasic.dart';

class SetupProfilePage extends StatefulWidget {
  const SetupProfilePage({Key? key}) : super(key: key);

  @override
  State<SetupProfilePage> createState() => _SetupProfilePageState();
}

class _SetupProfilePageState extends State<SetupProfilePage> {
  PageController pageController = PageController();
  final int maxPages = 5;
  int currentPage = 0;
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppbarBasic(
          appBar: AppBar(),
          onTap: () {
            Navigator.pushReplacementNamed(context, "/welcome");
          }),
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (val) {
              setState(() {
                currentPage = val;
                isLastPage = (currentPage == (maxPages - 1));
              });
            },
            children: const [
              SetupNicknamePage(),
              SetupBirthdayPage(),
              SetupSexPage(),
              SetupProgramTypePage(),
              SetupIntroPage()
            ],
          ),
          Container(
              alignment: const Alignment(0, 0.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Skip
                  BtnFlexible(
                    name: "Back",
                    onTap: () {
                      pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: maxPages,
                    effect: const WormEffect(
                      activeDotColor: Colors.indigo,
                    ),
                  ),
                  // Next or Done
                  isLastPage
                      ? BtnFlexible(
                          name: "Done",
                          onTap: () {
                            // Check if all required things filled
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => const SetupInterestPage(),
                              ),
                            );
                          },
                        )
                      : BtnFlexible(
                          name: "Next",
                          onTap: () {
                            if (currentPage == 0) {
                              if (pendingNickname != "") {
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              } else {
                                showMsg(context, "Empty Nickname!", Colors.red);
                              }
                            } else if (currentPage == 1) {
                              if (pendingBirth.year != DateTime.now().year) {
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              } else {
                                showMsg(context, "Empty Birthday!", Colors.red);
                              }
                            } else if (currentPage == 2) {
                              if (pendingSex != "--") {
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              } else {
                                showMsg(context, "Empty Gender!", Colors.red);
                              }
                            } else if (currentPage == 3) {
                              if (pendingProgramType != "--") {
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              } else {
                                showMsg(context, "Empty Major Program!", Colors.red);
                              }
                            }
                          },
                        ),
                ],
              )),
        ],
      ),
    );
  }
}
