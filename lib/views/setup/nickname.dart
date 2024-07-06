import 'package:flutter/material.dart';
import 'package:unimatch/config.dart';

import '../../components/tfBasic.dart';

class SetupNicknamePage extends StatefulWidget {
  const SetupNicknamePage({Key? key}) : super(key: key);

  @override
  State<SetupNicknamePage> createState() => _SetupNicknamePageState();
}

class _SetupNicknamePageState extends State<SetupNicknamePage> {
  TextEditingController teNickname = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (pendingNickname != "") {
      teNickname.text = pendingNickname;
    }
  }
  @override
  Widget build(BuildContext context) {
    teNickname.addListener(() {
      pendingNickname = teNickname.text;
    });
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("What's your nickname?", style: TextStyle(color: Colors.indigo.shade600, fontSize: 32, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 30,),
                  TfBasic(controller: teNickname, hint: "Enter Nickname"),
                  const SizedBox(height: 6,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("This is how it'll appear on your profile.", style: TextStyle(color: Colors.indigo.shade600, fontSize: 12),),
                      Row(
                        children: [
                          Icon(Icons.tips_and_updates, color: Colors.indigo.shade600, size: 18,),
                          const SizedBox(width: 2,),
                          Text("Can change it later.", style: TextStyle(color: Colors.indigo.shade600, fontSize: 12, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}