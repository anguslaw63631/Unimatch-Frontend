import 'package:flutter/material.dart';
import 'package:unimatch/config.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/fn.dart';
import 'package:unimatch/prefabs/abBasic.dart';
import 'package:unimatch/components/taOutlined.dart';

class UpdateIntroPage extends StatefulWidget {
  const UpdateIntroPage({Key? key, required this.notifyParent}) : super(key: key);
  final Function() notifyParent;
  @override
  State<UpdateIntroPage> createState() => _UpdateIntroPageState();
}

class _UpdateIntroPageState extends State<UpdateIntroPage> {
  TextEditingController teIntro = TextEditingController();
  @override
  Widget build(BuildContext context) {
    teIntro.text = clientUser.intro;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppbarBasic(
          appBar: AppBar(),
          title: "Edit About Me",
          enableActions: true,
          actions: [
            IconButton(onPressed: () async {
              await updateIntro(context, teIntro);
              widget.notifyParent();
              }, icon: Icon(Icons.save, color: appBarTextColor)),
          ],
          onTap: () {Navigator.pop(context);}
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              TaOutlined(controller: teIntro),
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
    );
  }
}
