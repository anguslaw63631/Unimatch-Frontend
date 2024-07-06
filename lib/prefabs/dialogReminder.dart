import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:unimatch/components/btnFlexible.dart';
import '../views/reminders/chatSafely.dart';

class DialogReminder extends StatefulWidget {
  const DialogReminder({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogReminder> createState() => _DialogReminderState();
}

class _DialogReminderState extends State<DialogReminder> {
  PageController pageController = PageController();
  final int maxPages = 3;
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 25),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.shield, color: Colors.indigo, size: 18,),
                  const SizedBox(width: 5,),
                  Text("Chat Safely", style: TextStyle(color: Colors.grey.shade700),)
                ],
              ),
              const SizedBox(height: 5,),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width,
                child: PageView(
                          controller: pageController,
                          onPageChanged: (val) {
                            setState(() {
                              isLastPage = (val == (maxPages - 1));
                            });
                          },
                          children: const [
                            ChatSafelyPage(
                              icon1: Icons.favorite,
                              icon2: Icons.shield,
                              title1: "Be respectful",
                              subTitle1: "Don't bully, harass, or threaten others. We don't support discrimination of any kind. UniMatch is no place for hate.",
                              title2: "Respect boundaries",
                              subTitle2: "Always get consent from people before talking about sex or expressing sexual desires.",
                            ),
                            ChatSafelyPage(
                              icon1: Icons.favorite,
                              icon2: Icons.paid,
                              title1: "Is it a scam?",
                              subTitle1: "Be mindful of someone playing on your emotions or claiming they desperately need money. It's okay to say \"NO\".",
                              title2: "Spot a get-rich-quick scheme",
                              subTitle2: "If someone promises a big cash-out that sounds too good to be true, it probably is a scam. Trust your gut.",
                            ),
                            ChatSafelyPage(
                              icon1: Icons.block_rounded,
                              icon2: Icons.flag_circle,
                              title1: "Take your time, if you want",
                              subTitle1: "You can always ask someone to get Photo Verified or video chat first before sharing too much info or meeting up",
                              title2: "Unmatch, block, or report",
                              subTitle2: "If someone crosses a line, tell us. Reports are treated confidentially. You can also block or unmatch them.",
                            ),
                          ],
                        ),
                ),
                SmoothPageIndicator(
                  controller: pageController,
                  count: maxPages,
                  effect: const WormEffect(
                    activeDotColor: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 50,),
                // Next or Done
                isLastPage ?
                BtnFlexible(name: "Got It!",
                  startColor: Colors.indigo,
                  endColor: Colors.indigoAccent,
                  ratio: 0.9,
                  fontSize: 16,
                  onTap: () {Navigator.of(context).pop();}
                ) :
                BtnFlexible(name: "Next",
                  startColor: Colors.indigo,
                  endColor: Colors.indigoAccent,
                  ratio: 0.9,
                  fontSize: 16,
                  onTap: () {pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);},
                ),
            ],
          ),
        ),
      ),
    );
  }
}