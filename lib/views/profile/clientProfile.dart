import 'dart:io';

import 'package:age_calculator/age_calculator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unimatch/config.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/fn.dart';
import 'package:unimatch/prefabs/abBasic.dart';
import 'package:unimatch/prefabs/pDetail.dart';
import 'package:unimatch/views/update/interest.dart';
import 'package:unimatch/views/update/intro.dart';
import 'package:unimatch/views/update/nickname.dart';

import '../../prefabs/pBasic.dart';

class ClientProfilePage extends StatefulWidget {
  const ClientProfilePage({Key? key}) : super(key: key);

  @override
  State<ClientProfilePage> createState() => _ClientProfilePageState();
}

class _ClientProfilePageState extends State<ClientProfilePage> {

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
          title: "Edit Profile",
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
                      child: GestureDetector(
                        onTap: () {Navigator.pushNamed(context, '/updateAvatar');},
                        child: Stack(
                          children: [
                            ClipRRect(borderRadius: BorderRadius.circular(10000.0),
                              child: CachedNetworkImage(
                                imageUrl: clientUser.avatar,
                                fit: BoxFit.cover,
                                width: 175,
                                height: 175,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress),
                                ),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                            ),
                            Positioned(
                              top: 125, left: 110,
                              child: ElevatedButton(
                                onPressed: () {Navigator.pushNamed(context, '/updateAvatar');},
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: EdgeInsets.zero,
                                  backgroundColor: Colors.white
                                ),
                                child: Icon(Icons.edit, color: Colors.indigo.shade800,),
                              )
                            ),
                          ]
                        ),
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
                      status: clientUser.username,
                    ),
                    PDetail(
                      title: "Email",
                      prefixIcon: Icons.email,
                      status: clientUser.email,
                    ),
                    PDetail(
                      title: "Gender",
                      prefixIcon: Icons.wc,
                      status: GENDER[int.parse(clientUser.sex)],
                    ),
                    PDetail(
                      title: "Birthday",
                      prefixIcon: Icons.cake,
                      status: DateFormat('dd-MM-yyyy').format(clientUser.birthday),
                    ),
                    PDetail(
                      title: "Constellation",
                      prefixIcon: Icons.water,
                      status: getConstellation(context, clientUser.birthday),
                    ),
                    PDetail(
                      title: "Age",
                      prefixIcon: Icons.calendar_month,
                      status: AgeCalculator.age(clientUser.birthday).years.toString(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                      child: Text("Basics", style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w700),),
                    ),
                    PBasic(
                        title: "Nickname",
                        status: clientUser.nickname,
                        prefixIcon: Icons.edit,
                        onTap: () {
                          Navigator.push (
                            context,
                            MaterialPageRoute (
                              builder: (context) => UpdateNicknamePage(notifyParent: refresh),
                            ),
                          );
                          },
                    ),
                    PBasic(
                      title: "Interests",
                      prefixIcon: Icons.sports_tennis,
                      status: "${clientUser.interest1 == 0 ? "Empty" : FULL_INTERESTS[clientUser.interest1]}, ${clientUser.interest2 == 0 ? "Empty" : FULL_INTERESTS[clientUser.interest2]}, ${clientUser.interest3 == 0 ? "Empty" : FULL_INTERESTS[clientUser.interest3]}",
                      onTap: () {
                        Navigator.push (
                          context,
                          MaterialPageRoute (
                            builder: (context) => UpdateInterestPage(notifyParent: refresh),
                          ),
                        );
                      },
                    ),
                    // Program Type
                    PBasic(
                      title: "Major Program",
                      prefixIcon: Icons.school,
                      status: clientUser.major == 0 ? "Empty" : FULL_PROGRAM_TYPES[clientUser.major], //clientUser.eduLevel,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              List options = FULL_PROGRAM_TYPES;
                              return SimpleDialog(
                                backgroundColor: Colors.white,
                                surfaceTintColor: Colors.transparent,
                                title: const Text("Select Major Program"),
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      physics:
                                      const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (ctx, index) {
                                        return SimpleDialogOption(
                                          onPressed: ()  {
                                            Navigator.pop(context);
                                            update(options, index);
                                          },
                                          child: Center(
                                            child: Text(options[index]),
                                          ),
                                        );
                                      },
                                      itemCount: options.length,
                                    ),
                                  )
                                ],
                              );
                            });
                      },
                    ),
                    PBasic(
                      title: "About Me",
                      prefixIcon: Icons.waving_hand,
                      status: clientUser.intro,
                      onTap: () {
                        Navigator.push (
                          context,
                          MaterialPageRoute (
                            builder: (context) => UpdateIntroPage(notifyParent: refresh),
                          ),
                        );
                      },
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
                    const SizedBox(height: 10,)
                  ],
                ))),
      ),
    );
  }

  update(List<dynamic> options, int index) async {
    await updateMajor(context, options[index]);
    setState(() {});
  }

  refresh() {
    setState(() {});
  }
}
