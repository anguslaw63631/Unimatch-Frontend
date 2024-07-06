import 'dart:io';

import 'package:age_calculator/age_calculator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/fn.dart';
import 'package:unimatch/prefabs/abBasic.dart';
import 'package:unimatch/prefabs/pDetail.dart';
import 'package:unimatch/templates/matchedUser.dart';

import '../../components/btnFlexible.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key,
    required this.matchedUser,
    required this.isFriend,
    this.notifyParent
  }) : super(key: key);
  final Function()? notifyParent;
  final MatchedUser matchedUser;
  final bool isFriend;
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  File? img;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.indigo.shade800;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade200,
      appBar: AppbarBasic(
          appBar: AppBar(),
          title: widget.matchedUser.nickname,
          elevation: 5,
          onTap: () {Navigator.pop(context);}
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                      child: Text("Avatar", style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w700),),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          ClipRRect(borderRadius: BorderRadius.circular(10000.0),
                            child: CachedNetworkImage(
                              imageUrl: widget.matchedUser.avatar,
                              fit: BoxFit.fitWidth,
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: MediaQuery.of(context).size.width * 0.95,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                            ),
                          ),
                        ]
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                    //   child: Text("Photos", style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w700),),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                      child: Text("Details", style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w700),),
                    ),
                    PDetail(
                      title: "Username",
                      prefixIcon: Icons.account_circle,
                      status: widget.matchedUser.username,
                    ),
                    PDetail(
                      title: "Email",
                      prefixIcon: Icons.email,
                      status: widget.matchedUser.email,
                    ),
                    PDetail(
                      title: "Gender",
                      prefixIcon: Icons.wc,
                      status: GENDER[int.parse(widget.matchedUser.sex)],
                    ),
                    PDetail(
                      title: "Birthday",
                      prefixIcon: Icons.cake,
                      status: DateFormat('dd-MM-yyyy').format(widget.matchedUser.birthday),
                    ),
                    PDetail(
                      title: "Constellation",
                      prefixIcon: Icons.water,
                      status: getConstellation(context, widget.matchedUser.birthday),
                    ),
                    PDetail(
                      title: "Age",
                      prefixIcon: Icons.calendar_month,
                      status: AgeCalculator.age(widget.matchedUser.birthday).years.toString(),
                    ),
                    PDetail(
                      title: "Interests",
                      prefixIcon: Icons.sports_tennis,
                      status: "${widget.matchedUser.interest1 == 0 ? "Empty" : FULL_INTERESTS[widget.matchedUser.interest1]}, ${widget.matchedUser.interest2 == 0 ? "Empty" : FULL_INTERESTS[widget.matchedUser.interest2]}, ${widget.matchedUser.interest3 == 0 ? "Empty" : FULL_INTERESTS[widget.matchedUser.interest3]}",
                    ),
                    PDetail(
                      title: "Major Program",
                      prefixIcon: Icons.school,
                      status: widget.matchedUser.major == 0 ? "Empty" : FULL_PROGRAM_TYPES[widget.matchedUser.major],
                    ),
                    PDetail(
                      title: "About Me",
                      prefixIcon: Icons.waving_hand,
                      status: widget.matchedUser.intro,
                    ),
                    // PBasic(
                    //   title: "District",
                    //   prefixIcon: Icons.place,
                    //   status: "", //clientUser.district,
                    //   onTap: () {},
                    // ),
                    // PBasic(
                    //   title: "MBTI",
                    //   prefixIcon: Icons.face,
                    //   status: clientUser.mbti,
                    //   onTap: () {},
                    // ),
                    // PBasic(
                    //   title: "Personalities",
                    //   prefixIcon: Icons.extension,
                    //   status: clientUser.personality,
                    //   onTap: () {},
                    // ),
                    // PBasic(
                    //   title: "Year of Intake",
                    //   prefixIcon: Icons.school,
                    //   status: "", //clientUser.eduLevel,
                    //   onTap: () {},
                    // ),
                    // PBasic(
                    //   title: "Education Level",
                    //   prefixIcon: Icons.school,
                    //   status: "", //clientUser.eduLevel,
                    //   onTap: () {},
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                    //   child: Text("About Me", style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w700),),
                    // ),
                    const SizedBox(height: 10,),
                    widget.isFriend ? Align(
                      alignment: Alignment.center,
                      child: BtnFlexible(
                          name: "Delete Friend",
                          ratio: 0.9,
                          onTap: () async {
                            // Delete Friends
                            var realId = await getFriendId(widget.matchedUser.id);
                            if (context.mounted && realId != null) {
                              await deleteFriend(context, realId);
                              widget.notifyParent!();
                            }
                          }
                      ),
                    ) : Align(
                      alignment: Alignment.center,
                      child: BtnFlexible(
                          name: "Send Friend Request",
                          ratio: 0.9,
                          onTap: () {
                            likeUser(context, widget.matchedUser.id);
                          }
                      ),
                    ),
                    const SizedBox(height: 10,),
                  ],
                ))),
      ),
    );
  }
}
