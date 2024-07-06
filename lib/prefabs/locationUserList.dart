import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unimatch/config.dart';
import 'package:unimatch/templates/LocationUser.dart';
import 'package:unimatch/templates/matchedUser.dart';
import 'package:unimatch/views/profile/userProfile.dart';

import '../fn.dart';

class LocationUserList extends StatefulWidget {
  LocationUser locationUser;

  LocationUserList({
    super.key,
    required this.locationUser,
  });

  @override
  State<LocationUserList> createState() => _LocationUserListState();
}

class _LocationUserListState extends State<LocationUserList> {
  final textColor = Colors.indigo.shade800;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await getFriendList();
        bool isFriend = false;
        for (int i = 0; i < friends.length; i++) {
          if (friends[i].id == widget.locationUser.id) {
            isFriend = true;
          }
        }
        if (context.mounted) {
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => UserProfilePage(
                  matchedUser: MatchedUser(
                      id: widget.locationUser.id,
                      avatar: widget.locationUser.avatar,
                      username: widget.locationUser.username,
                      nickname: widget.locationUser.nickname,
                      email: widget.locationUser.email,
                      sex: widget.locationUser.sex,
                      birthday: widget.locationUser.birthday,
                      interest1: widget.locationUser.interest1,
                      interest2: widget.locationUser.interest2,
                      interest3: widget.locationUser.interest3,
                      last_location: widget.locationUser.id,
                      major: widget.locationUser.major,
                      intro: widget.locationUser.intro,
                      createTime: widget.locationUser.createTime,
                      updateTime: widget.locationUser.updateTime),
                  isFriend: isFriend),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.locationUser.avatar,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.locationUser.nickname,
                      style: TextStyle(color: textColor, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        widget.locationUser.intro,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: textColor,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              "Within ${widget.locationUser.distance}m",
              style: TextStyle(color: textColor, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
