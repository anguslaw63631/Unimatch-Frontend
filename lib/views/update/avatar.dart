import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unimatch/const.dart';

import '../../config.dart';
import '../../fn.dart';
import '../../prefabs/abBasic.dart';

class UpdateAvatarPage extends StatefulWidget {
  const UpdateAvatarPage({Key? key}) : super(key: key);

  @override
  State<UpdateAvatarPage> createState() => _UpdateAvatarPageState();
}

class _UpdateAvatarPageState extends State<UpdateAvatarPage> {
  Future getImgFromSrc(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        pendingProfileAvatar = File(pickedFile.path);
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
          title: "Edit Avatar",
          icon: Icons.close,
          enableActions: true,
          actions: [
            IconButton(onPressed: () async {
              if (!isFileEmpty(context, 2, pendingProfileAvatar!)) {
                showLoadingCircle(context);
                String url = await uploadFile(2, pendingProfileAvatar!);
                String result = await updateUserAvatar(url);
                if (context.mounted) Navigator.pop(context);
                if (result == "true") {
                  if (context.mounted) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                      clientUser.avatar = url;
                  pendingProfileAvatar = null;
                  if (context.mounted) showMsg(context, "Update Avatar Successfully!", Colors.green);
                } else {
                  if (context.mounted) showMsg(context, "Update Avatar Failed!", Colors.green);
                }
              }
            }, icon: Icon(Icons.save, color: appBarTextColor,)),
          ],
          onTap: () {Navigator.pop(context);}
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              pendingProfileAvatar != null ? Image.file(
                pendingProfileAvatar!,
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.width * 0.95,
              ) : CachedNetworkImage(
                      imageUrl: clientUser.avatar,
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
  @override
  void dispose() {
    pendingProfileAvatar = null;
    super.dispose();
  }
}
