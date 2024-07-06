import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unimatch/fn.dart';
import 'package:unimatch/prefabs/abBasic.dart';
import 'package:unimatch/views/group/update/avatar.dart';
import '../../config.dart';
import '../../const.dart';
import '../../prefabs/pBasic.dart';

class AddGroupPage extends StatefulWidget {
  const AddGroupPage({Key? key, required this.notifyParent}) : super(key: key);

  final Function() notifyParent;

  @override
  State<AddGroupPage> createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  Color bgColor = Colors.indigoAccent;
  Color textColor = Colors.indigo.shade800;

  TextEditingController teTitle = TextEditingController();
  TextEditingController teNotice = TextEditingController();
  TextEditingController teDescription = TextEditingController();
  int type = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade200,
        appBar: AppbarBasic(
            appBar: AppBar(),
            title: "Add Group",
            enableActions: true,
            actions: [
              IconButton(onPressed: () async {
                if (checkIfEmpty()) {
                  // Add the group to Group List
                  if (!isFileEmpty(context, 2, pendingGroupAvatar!)) {
                    showLoadingCircle(context);
                    String url = await uploadFile(2, pendingGroupAvatar!);
                    String result = await addGroup(url, teTitle.text, type.toString(), teNotice.text, teDescription.text);
                    if (context.mounted) Navigator.pop(context);
                    if (result == "true") {
                      pendingGroupAvatar == null;
                      widget.notifyParent();
                      if (context.mounted) Navigator.pop(context);
                      pendingProfileAvatar = null;
                      if (context.mounted) showMsg(context, "Group Created Successfully!", Colors.green);
                    } else {
                      if (context.mounted) showMsg(context, "Group Create Failed!", Colors.red);
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
                    child: Text("Group Avatar", style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w700),),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute (
                            builder: (BuildContext context) => UpdateGroupAvatarPage(notifyParent: refresh),
                          ),
                        );
                        },
                      child: pendingProfileAvatar != null ? Image.file(
                        pendingProfileAvatar!,
                        width: 175,
                        height: 175,
                      ) : Stack(
                          children: [
                            pendingGroupAvatar != null ? Image.file(
                              pendingGroupAvatar!,
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
                                        builder: (BuildContext context) => UpdateGroupAvatarPage(notifyParent: refresh),
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
                    child: Text("Group Details", style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w700),),
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
                              "Group Title",
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
                              title: const Text("Group Type"),
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
                              "Group Notice",
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
                              "Group Description",
                              refresh));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  bool checkIfEmpty() {
    return teTitle.text != "Empty"
        && teNotice.text != "Empty"
        && teDescription.text != "Empty"
        && type != 0
        && pendingGroupAvatar != null;
  }

  refresh() {setState(() {});}

  @override
  void dispose() {
    pendingGroupAvatar = null;
    super.dispose();
  }
}
