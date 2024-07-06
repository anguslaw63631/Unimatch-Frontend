import 'package:flutter/material.dart';
import 'package:unimatch/components/btnFlexible.dart';
import 'package:unimatch/prefabs/abBasic.dart';

class AccountRecoveryPage extends StatefulWidget {
  const AccountRecoveryPage({Key? key}) : super(key: key);

  @override
  State<AccountRecoveryPage> createState() => _AccountRecoveryPageState();
}

class _AccountRecoveryPageState extends State<AccountRecoveryPage> {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text("Account Recovery", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 25,
                ),
                Text("Forgot your password, or username, or lost access to your account? We can help you login with your ITSC email.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade700)),
                const SizedBox(
                  height: 50,
                ),
                BtnFlexible(
                    ratio: 1,
                    height: 1,
                    name: "Login with ITSC email",
                    onTap: () {Navigator.pushNamed(context, "/sendRecovery");}),
                const SizedBox(height: 10,)
              ],
            ),
          ),
        ),
    );
  }
}