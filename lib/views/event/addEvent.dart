import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unimatch/fn.dart';
import 'package:unimatch/prefabs/abBasic.dart';
import 'package:unimatch/views/event/update/avatar.dart';
import '../../config.dart';
import '../../const.dart';
import '../../prefabs/pBasic.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key, required this.notifyParent}) : super(key: key);
  final Function() notifyParent;
  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  Color bgColor = Colors.indigoAccent;
  Color textColor = Colors.indigo.shade800;

  TextEditingController teTitle = TextEditingController();
  TextEditingController teNotice = TextEditingController();
  TextEditingController teDescription = TextEditingController();
  TextEditingController teLocation = TextEditingController();
  DateTime? date;
  TimeOfDay? time;
  int type = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade200,
        appBar: AppbarBasic(
            appBar: AppBar(),
            title: "Add Event",
            enableActions: true,
            actions: [
              IconButton(onPressed: () async {
                if (checkIfEmpty()) {
                  // Add the event to Group List
                  if (!isFileEmpty(context, 2, pendingEventAvatar!)) {
                    showLoadingCircle(context);
                    String url = await uploadFile(2, pendingEventAvatar!);
                    String result = await addEvent(
                        url,
                        teTitle.text,
                        type.toString(),
                        teNotice.text,
                        teDescription.text,
                        teLocation.text,
                        date!,
                        time!
                    );
                    if (context.mounted) Navigator.pop(context);
                    if (result == "true") {
                      pendingEventAvatar == null;
                      widget.notifyParent();
                      if (context.mounted) Navigator.pop(context);
                      pendingProfileAvatar = null;
                      if (context.mounted) showMsg(context, "Event Created Successfully!", Colors.green);
                    } else {
                      if (context.mounted) showMsg(context, "Event Create Failed!", Colors.red);
                    }
                  }
                } else {
                  showMsg(context, "Incomplete Fields!", Colors.red);
                }
              }, icon: Icon(Icons.add, color: appBarTextColor,)),
            ],
            onTap: () {Navigator.pop(context);}
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Text("Event Avatar", style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w700),),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                          MaterialPageRoute (
                            builder: (BuildContext context) => UpdateEventAvatarPage(notifyParent: refresh),
                          ),
                        );
                      },
                      child: pendingProfileAvatar != null ? Image.file(
                        pendingProfileAvatar!,
                        width: 175,
                        height: 175,
                      ) : Stack(
                          children: [
                            pendingEventAvatar != null ? Image.file(
                              pendingEventAvatar!,
                              width: 175,
                              height: 175,
                            ) : ClipRRect(borderRadius: BorderRadius.circular(10000.0),
                              child: CachedNetworkImage(
                                imageUrl: "https://www.kindpng.com/picc/m/22-223863_no-avatar-png-circle-transparent-png.png",
                                fit: BoxFit.cover,
                                width: 175,
                                height: 175,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress),
                                ),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                            ),
                            Positioned(
                                top: 125, left: 110,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                      MaterialPageRoute (
                                        builder: (BuildContext context) => UpdateEventAvatarPage(notifyParent: refresh),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: EdgeInsets.zero,
                                      backgroundColor: Colors.white
                                  ),
                                  child: Icon(Icons.edit, color: Colors.indigo.shade800,),
                                )
                            ),
                          ]
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                    child: Text("Event Details", style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w700),),
                  ),
                  PBasic(
                    title: "Title",
                    prefixIcon: Icons.title,
                    status: teTitle.text.isNotEmpty ? teTitle.text : "Empty",
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => buildSingleTextInputSheet(
                              context,
                              teTitle,
                              Icons.title,
                              "Event Title",
                              refresh));
                    },
                  ),
                  PBasic(
                    title: "Type",
                    prefixIcon: Icons.category,
                    status: type != 0 ? FULL_TYPES[type] : "Empty",
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              surfaceTintColor: Colors.transparent,
                              backgroundColor: Colors.white,
                              title: const Text("Event Type"),
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (ctx, index) {
                                      return SimpleDialogOption(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            type = index;
                                          });
                                        },
                                        child: Center(
                                          child: Text(FULL_TYPES[index]),
                                        ),
                                      );
                                    },
                                    itemCount: FULL_TYPES.length,
                                  ),
                                )
                              ],
                            );
                          });
                    },
                  ),
                  PBasic(
                    title: "Notice",
                    prefixIcon: Icons.announcement,
                    status: teNotice.text.isNotEmpty ? teNotice.text : "Empty",
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => buildSingleTextInputSheet(
                              context,
                              teNotice,
                              Icons.announcement,
                              "Event Notice",
                              refresh));
                    },
                  ),
                  PBasic(
                    title: "Description",
                    prefixIcon: Icons.edit,
                    status: teDescription.text.isNotEmpty ? teDescription.text : "Empty",
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => buildSingleTextInputSheet(
                              context,
                              teDescription,
                              Icons.edit,
                              "Event Description",
                              refresh));
                    },
                  ),
                  PBasic(
                    title: "Location",
                    prefixIcon: Icons.place,
                    status: teLocation.text.isNotEmpty ? teLocation.text : "Empty",
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => buildSingleTextInputSheet(
                              context,
                              teLocation,
                              Icons.place,
                              "Event Location",
                              refresh));
                    },
                  ),
                  PBasic(
                    title: "Date",
                    prefixIcon: Icons.calendar_month,
                    status: date != null ? dateTime2StringWithoutTime(date!) : "Empty",
                    onTap: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: date ?? DateTime.now(),
                        firstDate: DateTime.now(),
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
                      setState(() {date = newDate;});
                    },
                  ),
                  PBasic(
                    title: "Time",
                    prefixIcon: Icons.schedule,
                    status: time != null ? time2String(time!) : "Empty",
                    onTap: () async {
                      TimeOfDay? newTime = await showTimePicker(
                          context: context,
                          initialTime: time ?? TimeOfDay.now(),
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
                      if (newTime == null) return;
                      setState(() {time = newTime;});
                    },
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
    return DateTime(today.year + 1, today.month, today.day);
  }

  bool checkIfEmpty() {
    return teTitle.text != "Empty"
        && teNotice.text != "Empty"
        && teDescription.text != "Empty"
        && teLocation.text != "Empty"
        && type != 0
        && pendingEventAvatar != null
        && date != null
        && time != null;
  }

  refresh() {setState(() {});}

  @override
  void dispose() {
    pendingEventAvatar = null;
    super.dispose();
  }
}
