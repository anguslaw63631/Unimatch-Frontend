import 'package:flutter/material.dart';
import 'package:unimatch/config.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/templates/group.dart';

import '../fn.dart';

class GroupList extends StatefulWidget {
  const GroupList({
    super.key,
    required this.group,
    required this.notifyParent,
  });
  final SingleGroup group;
  final Function() notifyParent;
  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // show Join Event OR show already in Event
      },
      onLongPress: () {
        // if creator can delete OR update Event
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.indigoAccent,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.indigo.shade800, width: 1.5),
          ),
          // padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8,),
                child: Container(
                  height: 105,
                  width: 105,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      image: DecorationImage(
                        image: NetworkImage(widget.group.avatar),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.indigo.shade800
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.group.title,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                int.parse(widget.group.pplCount) > 1 ? "${widget.group.pplCount} Participants" : "${widget.group.pplCount} Participant",
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.group.description,
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              FULL_TYPES[widget.group.type],
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // Join the specific group
                            bool success = await joinGroupEvent(context, clientUser.id, widget.group.id);
                            if (success) widget.notifyParent();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(10),
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.yellow,
                          ),
                          child: Icon(Icons.person_add, color: Colors.indigo.shade800, size: 16,),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
