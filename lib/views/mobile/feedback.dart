import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:unimatch/fn.dart';
import 'package:unimatch/prefabs/abBasic.dart';
import 'package:unimatch/components/taOutlined.dart';

import '../../components/btnFlexible.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController teFeedback = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppbarBasic(
          appBar: AppBar(),
          title: "Give Feedback",
          onTap: () {Navigator.of(context).pop();}
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              TaOutlined(controller: teFeedback, hint: "Care to share more about it!"),
              const SizedBox(height: 16.0), 
              BtnFlexible(ratio: 1, name: "Submit", onTap: () async {
                final Email email = Email(
                  body: teFeedback.text,
                  subject: 'UniMatch Feedback',
                  recipients: ['unimatchhkust@gmail.com'],
                  isHTML: false,
                );
                showLoadingCircle(context);
                await FlutterEmailSender.send(email);
                if (context.mounted) {
                  Navigator.pop(context);
                  showMsg(context, "We received your valuable opinion! Thank you!", Colors.green);
                }
              },),
            ],
          ),
        ),
      ),
    );
  }
}