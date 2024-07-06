import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unimatch/convertFn.dart';
import 'package:unimatch/fn.dart';

class LikedUserList extends StatefulWidget {
  String id;
  String userId;
  String userNickname;
  String userAvatar;
  DateTime createTime;
  String remark;
  String status;
  LikedUserList({
    super.key,
    required this.id,
    required this.userId,
    required this.userNickname,
    required this.userAvatar,
    required this.createTime,
    required this.remark,
    required this.status,
    required this.notifyParent,
  });

  final Function() notifyParent;

  @override
  State<LikedUserList> createState() => _LikedUserListState();
}

class _LikedUserListState extends State<LikedUserList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.indigo.shade600,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 1/5,
              imageUrl: widget.userAvatar,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const CircleAvatar(
                backgroundImage: AssetImage("lib/images/noprofile.png"),
                radius: 30,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text("${widget.userNickname} @ ${formatTime(widget.createTime)}", style: const TextStyle(color: Colors.white,fontSize: 14),),
                    // const SizedBox(height: 4,),
                    // Text(widget.remark, style: const TextStyle(color: Colors.white, fontSize: 12),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await updateInvitation(context,
                              widget.id,
                              false,
                            );
                            widget.notifyParent();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(10),
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.yellow,
                          ),
                          child: Icon(Icons.close, color: Colors.indigo.shade800),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await updateInvitation(context,
                              widget.id,
                              true,
                            );
                            widget.notifyParent();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(10),
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.yellow,
                          ),
                          child: Icon(Icons.done, color: Colors.indigo.shade800),
                        )
                      ],
                    )
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
