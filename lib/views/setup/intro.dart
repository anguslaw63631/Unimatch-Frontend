import 'package:flutter/material.dart';
import 'package:unimatch/config.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/fn.dart';
import 'package:unimatch/prefabs/abBasic.dart';
import 'package:unimatch/components/taOutlined.dart';

class SetupIntroPage extends StatefulWidget {
  const SetupIntroPage({Key? key}) : super(key: key);
  @override
  State<SetupIntroPage> createState() => _SetupIntroPageState();
}

class _SetupIntroPageState extends State<SetupIntroPage> {
  @override
  void initState() {
    super.initState();
    if (pendingIntro != "") {
      teIntro.text = pendingIntro;
    }
  }

  TextEditingController teIntro = TextEditingController();
  @override
  Widget build(BuildContext context) {
    teIntro.addListener(() {
      pendingIntro = teIntro.text;
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
                Text("Introduce yourself?", style: TextStyle(color: Colors.indigo.shade600, fontSize: 32, fontWeight: FontWeight.bold),),
                const SizedBox(height: 16.0),
                TaOutlined(controller: teIntro, hint: "About Me"),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    const SizedBox(width: 6,),
                    Icon(Icons.tips_and_updates, color: Colors.indigo.shade800, size: 18,),
                    const SizedBox(width: 6,),
                    Text("Please do NOT input any\ncontact information and indecent languages!", style: TextStyle(color: Colors.indigo.shade800, fontSize: 10),),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
