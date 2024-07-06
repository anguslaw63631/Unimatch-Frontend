import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimatch/components/btnFlexible.dart';
import 'package:unimatch/components/tfBasic.dart';
import 'package:unimatch/fn.dart';
import 'package:unimatch/prefabs/abBasic.dart';

class UpdatePwdPage extends StatefulWidget {
  const UpdatePwdPage({Key? key}) : super(key: key);

  @override
  State<UpdatePwdPage> createState() => _UpdatePwdPageState();
}

class _UpdatePwdPageState extends State<UpdatePwdPage> {
  TextEditingController teOldPwd = TextEditingController();
  TextEditingController teNewPwd = TextEditingController();
  TextEditingController teNewPwdRepeat = TextEditingController();
  RxBool isOldPwdVisible = false.obs;
  RxBool isNewPwdVisible = false.obs;
  RxBool isNewPwdRepeatVisible = false.obs;
  RxBool isBtnActive = false.obs;

  @override
  void initState() {
    teNewPwdRepeat.addListener(() {
      if (isNotEmpty() && teNewPwd.text == teNewPwdRepeat.text && teOldPwd.text != teNewPwdRepeat.text) {
        isBtnActive.value = true;
      } else {
        isBtnActive.value = false;
      }
    });
    super.initState();
  }

  bool isNotEmpty() {
    return teOldPwd.text.isNotEmpty && teOldPwd.text.isNotEmpty && teOldPwd.text.isNotEmpty;
  }

  @override
  void dispose() {
    teOldPwd.dispose();
    teNewPwd.dispose();
    teNewPwdRepeat.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppbarBasic(
        appBar: AppBar(),
          onTap: () {Navigator.of(context).pop();}
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Update Password", style: TextStyle(color: Colors.indigo.shade600, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30,),
              Obx(() => TfBasic(
                controller: teOldPwd,
                hint: "Old Password",
                hideText: !isOldPwdVisible.value,
                suffixIcon: GestureDetector(
                    onLongPress: () {
                      isOldPwdVisible.value = true;
                    },
                    onLongPressEnd: (_) {
                      isOldPwdVisible.value = false;
                    },
                    child: Icon(Icons.visibility, color: Colors.indigo.shade600,)
                ),
              ),),
              Obx(() => TfBasic(
                controller: teNewPwd,
                hint: "New Password",
                hideText: !isNewPwdVisible.value,
                suffixIcon: GestureDetector(
                    onLongPress: () {
                      isNewPwdVisible.value = true;
                    },
                    onLongPressEnd: (_) {
                      isNewPwdVisible.value = false;
                    },
                    child: Icon(Icons.visibility, color: Colors.indigo.shade600,)
                ),
              ),),
              Obx(() => TfBasic(
                controller: teNewPwdRepeat,
                hint: "Repeat New Password",
                hideText: !isNewPwdRepeatVisible.value,
                suffixIcon: GestureDetector(
                    onLongPress: () {
                      isNewPwdRepeatVisible.value = true;
                    },
                    onLongPressEnd: (_) {
                      isNewPwdRepeatVisible.value = false;
                    },
                    child: Icon(Icons.visibility, color: Colors.indigo.shade600,)
                ),
              ),
              ),
              const SizedBox(height: 6,),
              // Text("We'll email you a link that will instantly log you in", style: TextStyle(color: Colors.indigo.shade600)),
              const SizedBox(
                height: 50,
              ),
              Obx(() => BtnFlexible(
                  ratio: 1,
                  height: 1,
                  name: "Update",
                  onTap: isBtnActive.value
                      ? () {
                        isBtnActive.value = false;
                        updatePwd(context, teOldPwd, teNewPwdRepeat);
                      }
                      : null),),
              const SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}
