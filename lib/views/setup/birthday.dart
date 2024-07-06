import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unimatch/config.dart';
import 'package:unimatch/components/taOutlined.dart';

class SetupBirthdayPage extends StatefulWidget {
  const SetupBirthdayPage({Key? key}) : super(key: key);

  @override
  State<SetupBirthdayPage> createState() => _SetupBirthdayPageState();
}

class _SetupBirthdayPageState extends State<SetupBirthdayPage> {
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
                Text("What's your birthday?", style: TextStyle(color: Colors.indigo.shade600, fontSize: 32, fontWeight: FontWeight.bold),),
                const SizedBox(height: 30,),
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      color: Colors.indigo.shade600,
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: pendingBirth.year == DateTime.now().year ? calLastDate() : pendingBirth,
                          firstDate: calFirstDate(),
                          lastDate: calLastDate(),
                          builder: (context, child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: Colors.indigoAccent,
                                    onPrimary: Colors.white,
                                    surface: Colors.white,
                                    onSurface: Colors.indigo.shade600,
                                  ),
                                  // dialogBackgroundColor:Colors.green[900],
                                ),
                                child: child!,
                              );
                          }
                        );
                        if (newDate == null) return;
                        setState(() {pendingBirth = newDate;});
                      },
                      icon: Icon(Icons.edit_calendar, color: Colors.indigo.shade600,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(pendingBirth.year == DateTime.now().year ? "--" : DateFormat('dd-MM-yyyy').format(pendingBirth),
                      style: TextStyle(color: Colors.indigo.shade600, fontSize: 24),),
                    ),
                  ],
                ),
                const SizedBox(height: 6,),
                Row(
                  children: [
                    Icon(Icons.tips_and_updates, color: Colors.indigo.shade600, size: 18,),
                    const SizedBox(width: 2,),
                    Text("Your profile shows your age, not your birth date", style: TextStyle(color: Colors.indigo.shade600, fontSize: 12, fontWeight: FontWeight.bold),),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DateTime calLastDate() {
    DateTime today = DateTime.now();
    return DateTime(today.year - 18, today.month, today.day);
  }

  DateTime calFirstDate() {
    DateTime today = DateTime.now();
    return DateTime(today.year - 50, today.month, today.day);
  }
}
