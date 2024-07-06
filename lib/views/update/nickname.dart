import 'package:flutter/material.dart';
import 'package:unimatch/config.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/fn.dart';
import '../../components/tfBasic.dart';
import '../../prefabs/abBasic.dart';

class UpdateNicknamePage extends StatefulWidget {
  const UpdateNicknamePage({Key? key, required this.notifyParent}) : super(key: key);
  final Function() notifyParent;
  @override
  State<UpdateNicknamePage> createState() => _UpdateNicknamePageState();
}

class _UpdateNicknamePageState extends State<UpdateNicknamePage> {
  TextEditingController teNickname = TextEditingController();
  @override
  Widget build(BuildContext context) {
    teNickname.text = clientUser.nickname;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppbarBasic(
          appBar: AppBar(),
          title: "Edit Nickname",
          enableActions: true,
          actions: [
            IconButton(onPressed: () async {
              await updateNickname(context, teNickname);
              widget.notifyParent();
              }, icon: Icon(Icons.save, color: appBarTextColor)),
          ],
          onTap: () {Navigator.pop(context);}
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        Text("Please do NOT input any\ncontact information and indecent languages!", style: TextStyle(color: Colors.indigo.shade600, fontSize: 12, fontWeight: FontWeight.bold),),
                      ],
                    ),
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
