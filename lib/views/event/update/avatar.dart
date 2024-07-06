import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unimatch/const.dart';

import '../../../config.dart';
import '../../../prefabs/abBasic.dart';

class UpdateEventAvatarPage extends StatefulWidget {
  const UpdateEventAvatarPage({Key? key, required this.notifyParent}) : super(key: key);

  final Function() notifyParent;

  @override
  State<UpdateEventAvatarPage> createState() => _UpdateEventAvatarPageState();
}

class _UpdateEventAvatarPageState extends State<UpdateEventAvatarPage> {
  Future getImgFromSrc(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        pendingEventAvatar = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppbarBasic(
          appBar: AppBar(),
          title: "Add Event Avatar",
          icon: Icons.close,
          enableActions: true,
          actions: [
            IconButton(onPressed: () {
              widget.notifyParent();
              Navigator.pop(context);
            }, icon: Icon(Icons.save, color: appBarTextColor,)),
          ],
          onTap: () {Navigator.pop(context);}
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              pendingEventAvatar != null ? Image.file(
                pendingEventAvatar!,
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.width * 0.95,
              ) : CachedNetworkImage(
                      imageUrl: "https://www.kindpng.com/picc/m/22-223863_no-avatar-png-circle-transparent-png.png",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.width * 0.95,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () => getImgFromSrc(ImageSource.gallery),
                      icon: const Icon(Icons.collections, color: Colors.black)
                  ),
                  IconButton(
                      onPressed: () => getImgFromSrc(ImageSource.camera),
                      icon: const Icon(Icons.photo_camera, color: Colors.black)
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
