import 'package:flutter/material.dart';
import 'package:unimatch/prefabs/abBasic.dart';
import 'package:unimatch/components/btnBottom.dart';

import '../../const.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppbarBasic(
            appBar: AppBar(),
            onTap: () {Navigator.of(context).pop();}
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'lib/images/logo.png',
                    fit: BoxFit.contain,
                    height: 75,
                  ),
                  const Text("Welcome to UniMatch.", style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Please follow these House Rules.", style: TextStyle(color: appBarTextColor)),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Be yourself.", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Make sure your photos, age, and bio are true to who you are.", style: TextStyle(color: appBarTextColor)),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Stay Safe.", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Don't be too quick to give out personal information.", style: TextStyle(color: appBarTextColor)),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Play it cool.", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Respect others and treat them as you would like to be treated.", style: TextStyle(color: appBarTextColor)),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Be proactive.", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Always report bad behaviors.", style: TextStyle(color: appBarTextColor)),
                  BtnBottom(
                      name: "I agree",
                      onTap: () {Navigator.pushReplacementNamed(context, "/setupProfile");
                      }
                      ),
                 const SizedBox(height: 10,)
              ],
          ),
        ),
    );
  }
}
