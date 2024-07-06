import 'package:flutter/material.dart';

class ChatSafelyPage extends StatefulWidget {

  final IconData icon1;
  final IconData icon2;
  final String? title1;
  final String? subTitle1;
  final String? title2;
  final String? subTitle2;

  const ChatSafelyPage({
    super.key,
    required this.icon1,
    required this.icon2,
    this.title1,
    this.subTitle1,
    this.title2,
    this.subTitle2,
  });

  @override
  State<ChatSafelyPage> createState() => _ChatSafelyPageState();
}

class _ChatSafelyPageState extends State<ChatSafelyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(widget.icon1, color: Colors.indigoAccent, size: 50,),
              Icon(widget.icon2, color: Colors.indigoAccent, size: 50,),
            ],
          ),
          const SizedBox(height: 10,),
          Text(widget.title1 ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
          const SizedBox(height: 5,),
          Text(widget.subTitle1 ?? "", style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
          const SizedBox(height: 10,),
          Text(widget.title2 ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 5,),
          Text(widget.subTitle2 ?? "", style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
        ],
      )
    );
  }
}
