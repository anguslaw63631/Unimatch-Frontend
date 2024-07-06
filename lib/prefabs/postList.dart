import 'package:flutter/material.dart';

class PostList extends StatefulWidget {
  String userImg;
  String name;
  String location;
  String postTime;
  String desc;
  String postImg;
  String likeCount;
  PostList({
    super.key,
    required this.userImg,
    required this.name,
    required this.location,
    required this.postTime,
    required this.desc,
    required this.postImg,
    required this.likeCount,
  });

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.indigoAccent,
            width: 1.0,
          ),
          bottom: BorderSide(
            color: Colors.indigoAccent,
            width: 1.0,
          ),
        ),
        color: Colors.indigo,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(widget.userImg),
                      maxRadius: 25,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.location,
                            style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            widget.postTime,
                            style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, color: Colors.white,))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Text(
              widget.desc,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          Container(
            height: 256,
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(widget.postImg),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border, color: Colors.white,),),
                  Text(widget.likeCount, style: const TextStyle(color: Colors.white, fontSize: 14),),
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.message, color: Colors.white,),
              )
            ],
          )
        ],
      ),
    );
  }
}
