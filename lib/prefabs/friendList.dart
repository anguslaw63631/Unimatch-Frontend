import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unimatch/templates/matchedUser.dart';
import 'package:unimatch/views/profile/userProfile.dart';

class FriendList extends StatefulWidget {
  MatchedUser friend;

  FriendList({
    super.key,
    required this.friend,
  });

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  final textColor = Colors.indigo.shade800;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push (
          context,
          MaterialPageRoute (
            builder: (BuildContext context) => UserProfilePage(matchedUser: widget.friend, isFriend: true,),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.friend.avatar,
                  fit: BoxFit.cover,
                  width: 65,
                  height: 65,
                  progressIndicatorBuilder:
                      (context, url, downloadProgress) => Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                ),
                const SizedBox(width: 16,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.friend.nickname, style: TextStyle(color: textColor,fontSize: 16),),
                    const SizedBox(height: 8,),
                    Text(widget.friend.email, style: TextStyle(color: textColor,fontSize: 14),),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
