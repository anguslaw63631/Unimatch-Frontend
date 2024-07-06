// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:unimatch/fn.dart';
import 'package:unimatch/userPreferences.dart';

import '../../components/btnNormal.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    if (UserPreferences.getUsername() != null) {
      teUsername.text = UserPreferences.getUsername()!;
    }
    if (UserPreferences.getPwd() != null) {
      tePwd.text = UserPreferences.getPwd()!;
    }
  }

  // text editing controllers
  TextEditingController teITSC = TextEditingController();
  TextEditingController teUsername = TextEditingController();
  TextEditingController tePwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.indigo.shade700,
      body: SafeArea(
          child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        'lib/images/logo.png',
                        fit: BoxFit.contain,
                        height: 75,
                      ), // logo
                      Column(
                        children: [
                          const Text("By clicking LOGIN, you agree with our Terms. Learn how we process your data in our Privacy & Cookies Policy.", style: TextStyle(color: Colors.white, fontSize: 12),),
                          // Navigator.pushNamed(context, "/register");
                          const SizedBox(
                            height: 10,
                          ),
                          btnNormal(
                              color: Colors.black,
                              bgColor: Colors.white,
                              name: "LOGIN",
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) => buildLoginSheet(context, teUsername, tePwd));
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          btnNormal(
                              color: Colors.black,
                              bgColor: Colors.white,
                              name: "REGISTER WITH ITSC",
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) => buildRegisterSheet(context, teITSC));
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed("/accountRecovery");
                            },
                            child: const Text("Trouble logging in?", style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                        ],
                      ),
                      // signIn Fn
                    ],
                  ),
                ),
              ))),
    );
  }
}
