import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:unimatch/config.dart';
import 'package:unimatch/const.dart';

class SetupSexPage extends StatefulWidget {
  const SetupSexPage({Key? key}) : super(key: key);

  @override
  State<SetupSexPage> createState() => _SetupSexPageState();
}

class _SetupSexPageState extends State<SetupSexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What's your gender?",
                    style: TextStyle(
                        color: Colors.indigo.shade600,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  DropdownButtonFormField<String>(
                      dropdownColor: Colors.white,
                      icon: Icon(                // Add this
                        Icons.arrow_drop_down,  // Add this
                        color: Colors.indigo.shade600,   // Add this
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(width: 1, color: Colors.indigo.shade600),
                        ),
                      ),
                      value: pendingSex,
                      items: FULL_GENDER
                          .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item,
                                  style: TextStyle(
                                      color: Colors.indigo.shade600, fontSize: 18))))
                          .toList(),
                      onChanged: (item) {
                        setState(() {
                          pendingSex = item!;
                        });
                      }),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.tips_and_updates,
                        color: Colors.indigo.shade600,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "Gender can be set ONCE only!",
                        style: TextStyle(
                            color: Colors.indigo.shade600,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
