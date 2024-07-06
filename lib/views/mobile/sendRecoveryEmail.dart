import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimatch/fn.dart';
import 'package:unimatch/prefabs/abBasic.dart';

import '../../components/btnFlexible.dart';
import '../../components/tfBasic.dart';

class SendRecoveryPage extends StatefulWidget {
  const SendRecoveryPage({Key? key}) : super(key: key);

  @override
  State<SendRecoveryPage> createState() => _SendRecoveryPageState();
}


class _SendRecoveryPageState extends State<SendRecoveryPage> {
  TextEditingController teITSC = TextEditingController();
  RxBool isBtnActive = false.obs;

  @override
  void initState() {
    super.initState();
    teITSC.addListener(() {
      isBtnActive.value = teITSC.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    teITSC.dispose();
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
              Text("Login by ITSC email", style: TextStyle(color: Colors.indigo.shade600, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30,),
              TfBasic(
                  controller: teITSC,
                  hint: "Your ITSC (Without @connect.ust.hk)",
              ),
              const SizedBox(height: 6,),
              Text("We'll email you a password that help you log in", style: TextStyle(color: Colors.indigo.shade600)),
              const SizedBox(
                height: 50,
              ),
              Obx(() => BtnFlexible(
                  ratio: 1,
                  height: 1,
                  name: "Send Email",
                  onTap: isBtnActive.value
                      ? () {isBtnActive.value = false; retrievePwd(context, teITSC.text);}
                      : null),),
              const SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}
