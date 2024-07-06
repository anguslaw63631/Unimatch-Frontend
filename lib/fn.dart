// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:io';
import 'package:image/image.dart' as ImageProcess;
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'dart:convert';
import 'package:unimatch/config.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/prefabs/matchedUserCard.dart';
import 'package:unimatch/templates/LocationUser.dart';
import 'package:unimatch/templates/Message.dart';
import 'package:unimatch/templates/chatFriend.dart';
import 'package:unimatch/templates/group.dart';
import 'package:unimatch/templates/likedUser.dart';
import 'package:unimatch/templates/matchedUser.dart';
import 'package:unimatch/userPreferences.dart';
import 'package:http/http.dart' as http;
import 'components/btnNormal.dart';
import 'components/tfOutlined.dart';
import 'templates/event.dart';

var regURL = "${domain}register";
var updateURL = "${domain}user";
var getURL = "${domain}user";
var messageURL = "${domain}message";
var locationMatchURL = "${domain}match/location";
var normalMatchURL = "${domain}match/normal";
var friendInvitationURL = "${domain}invitation";
var friendURL = "${domain}friend";

Future signUserIn(BuildContext context, TextEditingController teUsername,
    TextEditingController tePwd) async {
  var data;
  if (teUsername.text == "" || tePwd.text == "") {
    showMsg(context, "Empty Fields!", Colors.red);
  } else {
    UserPreferences.setUsername(teUsername.text);
    UserPreferences.setPwd(tePwd.text);
    // Show loading circle
    showLoadingCircle(context);
    try {
      var response = await http.post(Uri.parse("${domain}login"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "username": teUsername.text,
            "password": tePwd.text
          }));
      if (response.statusCode == 200) {
        data = (jsonDecode(utf8.decode(response.bodyBytes)))["data"];
        // debugPrint(data["token"]);
        UserPreferences.setToken(data["token"]);
        clientUser.id = data["id"];
        clientUser.avatar = data["avatar"];
        clientUser.nickname = data["nickname"];
        clientUser.username = data["username"];
        clientUser.email = data["email"];
        clientUser.intro = data["intro"];
        clientUser.interest1 = data["interest1"];
        clientUser.interest2 = data["interest2"];
        clientUser.interest3 = data["interest3"];
        clientUser.major = data["major"];
        clientUser.sex = data["sex"];
        isLogged.value = true;
        Navigator.pop(context);
        if (data["birthday"] == null) {
          Navigator.pushReplacementNamed(context, "/welcome");
          showMsg(context, "Login Successfully!", Colors.green);
        } else {
          clientUser.birthday = string2DateTime(data["birthday"]);
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, "/primary");
          showMsg(context, "Login Successfully!", Colors.green);
        }
      } else {
        Navigator.pop(context);
        showMsg(context, "Login Failed!", Colors.red);
      }
    } catch (err) {
      Navigator.pop(context);
      showMsg(context, "Login Failed!", Colors.red);
      debugPrint(err.toString());
    }
  }
}

Future regUser(BuildContext context, TextEditingController teITSC) async {
  var data;
  if (teITSC.text == "") {
    showMsg(context, "Empty Fields!", Colors.red);
  } else {
    showLoadingCircle(context);
    try {
      var response = await http.post(Uri.parse(regURL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "username": teITSC.text,
          }));
      // debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        Navigator.pop(context);
        data = jsonDecode(utf8.decode(response.bodyBytes));
        // debugPrint(data.toString());
        if (data["success"] == false) {
          showMsg(context, data["message"], Colors.red);
        } else {
          showMsg(context, "Register Successfully!\nPlease check your ITSC email!", Colors.green);
        }
      } else {
        Navigator.pop(context);
        showMsg(context, "Register Failed!", Colors.red);
      }
    } catch (err) {
      showMsg(context, "Unknown Error!", Colors.red);
      debugPrint(err.toString());
    }
  }
}

Future likeUser(BuildContext context, String friendId) async {
  var data;
  showLoadingCircle(context);
  try {
    var response = await http.post(Uri.parse(friendInvitationURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Token' : '${UserPreferences.getToken()}',
        },
        body: jsonEncode(<String, String>{
          "friendId": friendId,
        }));
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["success"] == false) {
        showMsg(context, data["message"], Colors.red);
      } else {
        showMsg(context, "Like Successfully!", Colors.green);
      }
    } else {
      Navigator.pop(context);
      showMsg(context, "Like Failed!", Colors.red);
    }
  } catch (err) {
    showMsg(context, "Unknown Error!", Colors.red);
    debugPrint(err.toString());
  }
}

Future updateInvitation(BuildContext context, String invitationId, bool status) async {
  var data;
  showLoadingCircle(context);
  try {
    var response = await http.put(Uri.parse("${domain}invitation/handle"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Token' : '${UserPreferences.getToken()}',
        },
        body: jsonEncode(<String, String>{
          "id": invitationId,
          "reason": "",
          "remark": "",
          "status": status ? "1" : "2",
        }));
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["success"] == false) {
        showMsg(context, data["message"], Colors.red);
      } else {
        status ?
        showMsg(context, "Invitation Accepted!", Colors.green)
        : showMsg(context, "Invitation Declined!", Colors.green);
      }
    } else {
      Navigator.pop(context);
      status ?
      showMsg(context, "Invitation Accept Failed!", Colors.red)
      : showMsg(context, "Invitation Decline Failed!", Colors.red);
    }
  } catch (err) {
    showMsg(context, "Unknown Error!", Colors.red);
    debugPrint(err.toString());
  }
}

Future updateFriendMsgStatus(BuildContext context, String msgId, String status) async {
  var data;
  try {
    var response = await http.put(Uri.parse("${domain}friendMsg/msgHandle"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Token' : '${UserPreferences.getToken()}',
        },
        body: jsonEncode(<String, String>{
          "id": msgId,
          "type": status,
        }));
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["success"] != true) {
        showMsg(context, data["message"], Colors.red);
      }
    } else {
      // debugPrint("Msg Status Update Failed!");
    }
  } catch (err) {
    debugPrint(err.toString());
  }
}

Future updateGroupMsgStatus(BuildContext context, String msgId, String status) async {
  var data;
  try {
    var response = await http.put(Uri.parse("${domain}group/msgHandle"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Token' : '${UserPreferences.getToken()}',
        },
        body: jsonEncode(<String, String>{
          "id": msgId,
          "type": status,
        }));
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["success"] != true) {
        showMsg(context, data["message"], Colors.red);
      }
    } else {
      // debugPrint("Msg Status Update Failed!");
    }
  } catch (err) {
    debugPrint(err.toString());
  }
}

Future sendFriendMsg(String fromUserId, String toUserId, String msgContent, String msgType) async {
  var data;
  try {
    var response = await http.post(Uri.parse("${domain}friendMsg"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Token' : '${UserPreferences.getToken()}',
        },
        body: jsonEncode(<String, String>{
          "fromUserId": fromUserId,
          "toUserId": toUserId,
          "msgContent": msgContent,
          "msgType": msgType,
        }));
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["success"] == false) {
      } else {
        // debugPrint("Msg Sent!");
      }
    } else {
      // debugPrint("Msg Send Failed!");
    }
  } catch (err) {
    debugPrint(err.toString());
  }
}

Future verifyAvatar(BuildContext context, File image) async {
  final imageFile = ImageProcess.decodeImage(
    image.readAsBytesSync(),
  );
  String base64Image = base64Encode(ImageProcess.encodePng(imageFile!));
  var data;
  showLoadingCircle(context);
  try {
    var response = await http.post(Uri.parse("https://rggsj3q2jc.execute-api.ap-northeast-1.amazonaws.com/photoVerify"),
        headers: <String, String>{
          // 'Content-Type': 'application/json; charset=UTF-8',
          // 'Access-Token' : '${UserPreferences.getToken()}',
        },
        body: jsonEncode(<String, String>{
          "body": "{\"image\":\"$base64Image\"}"
        }));
    // debugPrint(base64Image);
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = (jsonDecode(utf8.decode(response.bodyBytes))["body"]);
      // debugPrint(data.toString());
      if (data.toString().contains("Gender")) {
        Navigator.pop(context);
        Navigator.pop(context);
        showMsg(context, "Person Verified!", Colors.green);
        String url = await uploadFile(2, image);
        await updateUserAvatar(url);
        clientUser.avatar = url;
      } else {
        showMsg(context, "Invalid Image!", Colors.red);
      }
    } else {
      showMsg(context, "Verify Failed!", Colors.red);
    }
  } catch (err) {
    debugPrint(err.toString());
  }
}


Future sendGroupMsg(String fromUserId, String fromUserNickname, String fromUserAvatar, String groupId, String msgContent, String msgType) async {
  var data;
  try {
    var response = await http.post(Uri.parse("${domain}groupMsg"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Token' : '${UserPreferences.getToken()}',
        },
        body: jsonEncode(<String, String>{
          "fromUserId": fromUserId,
          "fromUserNickname": fromUserNickname,
          "fromUserAvatar": fromUserAvatar,
          "groupId": groupId,
          "msgContent": msgContent,
          "msgType": msgType,
        }));
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
      debugPrint(data.toString());
      if (data["success"] != false) {
        // debugPrint("Msg Sent!");
      }
    } else {
      // debugPrint("Msg Send Failed!");
    }
  } catch (err) {
    debugPrint(err.toString());
  }
}

Future deleteFriend(BuildContext context, String friendId) async {
  var data;
  showLoadingCircle(context);
  try {
    var response = await http.delete(Uri.parse("${domain}friend/$friendId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Token' : '${UserPreferences.getToken()}',
        },);
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Navigator.pop(context);
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["success"] == false) {
        showMsg(context, data["message"], Colors.red);
      } else {
        Navigator.pop(context);
        showMsg(context, "Friend Deleted Successfully!", Colors.green);
      }
    } else {
      showMsg(context, "Friend Delete Failed!", Colors.red);
    }
  } catch (err) {
    showMsg(context, "Unknown Error!", Colors.red);
    debugPrint(err.toString());
  }
}

Future getAllUsers() async {
  matchedUsers.clear();
  matchedUserCards.clear();
  var data;
  try {
    var response = await http.get(Uri.parse(normalMatchURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Token' : '${UserPreferences.getToken()}'
      },
    );
    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["data"]["records"] != null) {
        List users = data["data"]["records"];
        // Remove null users or non-setup users
        users.removeWhere((value) => value == null);
        users.removeWhere((value) => value["birthday"] == null);
        // debugPrint(users.length.toString());
        // Create list of matched users
        for (int i = 0; i < users.length; i++) {
          if (UserPreferences.getBanId() != null) {
            if (UserPreferences.getBanId()!.contains(users[i]["id"].toString())) {
              continue;
            }
          }
          matchedUsers.add(
              MatchedUser(
                id: users[i]["id"].toString(),
                avatar: users[i]["avatar"],
                username: users[i]["username"],
                nickname: users[i]["nickname"],
                email: users[i]["email"],
                birthday: string2DateTime(users[i]["birthday"]),
                intro: users[i]["intro"],
                createTime: string2DateTime(users[i]["createTime"]),
                updateTime: string2DateTime(users[i]["updateTime"]),
                sex: users[i]["sex"].toString(),
                interest1: users[i]["interest1"],
                interest2: users[i]["interest2"],
                interest3: users[i]["interest3"],
                major: users[i]["major"],
                last_location: users[i]["last_location"].toString(),
              )
          );
          matchedUserCards.add(
              MatchedUserCard(
                  matchedUser: matchedUsers.last
              )
          );
        }
        // debugPrint(matchedUserCards.length.toString());
      } else {}
    } else {}
  } catch (err) {
    debugPrint(err.toString());
  }
  return matchedUsers;
}

Future getConversationList() async {
  chatFriends.clear();
  var data;
  try {
    var response = await http.post(Uri.parse(messageURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Token' : '${UserPreferences.getToken()}'
      },
    );
    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["data"] != null) {
        List cf = data["data"];
        for (int i = 0; i < cf.length; i++) {
          bool isGroup = await isGroupExistById(cf[i]["toUserId"].toString());
          chatFriends.add(
              ChatFriend(
                lastMsg: cf[i]["lastContent"],
                lastTime: DateTime.parse(cf[i]["lastTime"]),
                msgType: cf[i]["msgType"].toString(),
                fromUserId: cf[i]["fromUserId"].toString(),
                toUserId: cf[i]["toUserId"].toString(),
                toUserName: cf[i]["targetName"],
                toUserAvatar: cf[i]["targetAvatar"],
                toUserNickname: cf[i]["nickname"],
                unread: cf[i]["unread"].toString(),
                status: cf[i]["status"].toString(),
                isGroup: isGroup,
              )
          );
        }
        // debugPrint(chatUsers.length.toString());
      } else {}
    } else {}
  } catch (err) {
    debugPrint(err.toString());
  }
  return chatFriends;
}

Future getLikedUserList() async {
  likedUsers.clear();
  var data;
  try {
    final params = {
      "friendId": clientUser.id,
    };
    var response = await http.get(Uri.http('server_ip:8003', '/unimatch-api/invitation', params),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Token' : '${UserPreferences.getToken()}'
      },
    );
    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["data"] != null) {
        List lu = data["data"];
        // Create list of liked users
        for (int i = 0; i < lu.length; i++) {
          if (lu[i]["status"] != 1 && lu[i]["status"] != 2) {
            likedUsers.add(
                LikedUser(
                  id: lu[i]["id"].toString(),
                  userId: lu[i]["userId"].toString(),
                  userNickname: lu[i]["userNickname"],
                  userAvatar: lu[i]["userAvatar"],
                  createTime: DateTime.parse(lu[i]["updateTime"]),
                  remark: lu[i]["remark"] ?? "",
                  status: lu[i]["status"].toString(),
                )
            );
          }
        }
        // debugPrint(likedUsers.length.toString());
      } else {}
    } else {}
  } catch (err) {
    debugPrint(err.toString());
  }
  return likedUsers;
}

Future getEventList() async {
  events.clear();
  var data;
  try {
    var response = await http.get(Uri.parse("${domain}match/group"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Token' : '${UserPreferences.getToken()}'
      },
    );
    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
      if (data["data"] != null) {
        List e = data["data"]["records"];
        // debugPrint(e.toString());
        // Remove all groups and null value
        e.removeWhere((value) => value == null);
        e.removeWhere((value) => value["groupeventlocation"] == null || value["groupeventtime"] == null);
        // e = e.reversed.toList();
        // debugPrint(e.toString());
        // Create list of events
          for (int i = 0; i < e.length; i++) {
              int pplCount = await getGroupEventPpl(e[i]["id"]);
              if (!events.any((val) => val.id == e[i]["id"])) {
                events.add(
                    SingleEvent(
                      id: e[i]["id"],
                      avatar: e[i]["avatar"],
                      title: e[i]["name"],
                      notice: e[i]["notice"],
                      description: e[i]["intro"],
                      type: e[i]["tag"],
                      pplCount: pplCount.toString(),
                      location: e[i]["groupeventlocation"],
                      time: string2DateTime(e[i]["groupeventtime"]),
                    )
                );
              }
          }
        // debugPrint(events.toString());
      } else {}
    } else {}
  } catch (err) {
    debugPrint(err.toString());
  }
  return events;
}

Future getGroupList() async {
  groups.clear();
  var data;
  try {
    var response = await http.get(Uri.parse("${domain}match/group"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Token' : '${UserPreferences.getToken()}'
      },
    );
    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
      if (data["data"] != null) {
        List e = data["data"]["records"];
        // debugPrint(e.toString());
        // Remove all events and null value
        e.removeWhere((value) => value == null);
        e.removeWhere((value) => value["groupeventlocation"] != null || value["groupeventtime"] != null);
        e = e.reversed.toList();
        debugPrint(e.toString());
        // Create list of groups
        for (int i = 0; i < e.length; i++) {
            int pplCount = await getGroupEventPpl(e[i]["id"]);
            if (!groups.any((val) => val.id == e[i]["id"])) {
              groups.add(SingleGroup(
                id: e[i]["id"],
                avatar: e[i]["avatar"],
                title: e[i]["name"],
                notice: e[i]["notice"],
                description: e[i]["intro"],
                type: e[i]["tag"],
                pplCount: pplCount.toString(),
              ));
            }
        }
        // debugPrint(events.toString());
      } else {}
    } else {}
  } catch (err) {
    debugPrint(err.toString());
  }
  return groups;
}

Future getGroupEventPpl(String groupId) async {
  var data;
  int pplCount = 0;
  try {
    var response = await http.get(Uri.parse("${domain}group/$groupId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Token' : '${UserPreferences.getToken()}'
      },
    );
    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
      if (data["data"] != null) {
        List e = data["data"]["groupUsers"];
        // debugPrint(e.toString());
        // Remove all events and null value
        e.removeWhere((value) => value == null);
        // debugPrint(e.toString());
        pplCount = e.length;
      } else {}
    } else {}
  } catch (err) {
    debugPrint(err.toString());
  }
  return pplCount;
}

Future getGroupEventUsersById(String groupId) async {
  List<String> groupEventUsersId = [];
  var data;
  try {
    var response = await http.get(Uri.parse("${domain}group/$groupId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Token' : '${UserPreferences.getToken()}'
      },
    );
    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
      if (data["data"] != null) {
        List e = data["data"]["groupUsers"];
        // debugPrint(e.toString());
        // Remove all events and null value
        e.removeWhere((value) => value == null);
        for (int i = 0; i < e.length; i++) {
          groupEventUsersId.add(e[i]["userId"]);
        }
        // debugPrint(e.toString());
        // debugPrint(groupEventUsersId.toString());
      } else {}
    } else {}
  } catch (err) {
    debugPrint(err.toString());
  }
  return groupEventUsersId;
}

Future getUserDetailById(String userId) async {
  var data;
  try {
    var response = await http.get(Uri.parse("${domain}user/$userId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Token' : '${UserPreferences.getToken()}'
      },
    );
    if (response.statusCode == 200) {
      data = (jsonDecode(utf8.decode(response.bodyBytes)))["data"];
      // debugPrint(data.toString());
      if (data != null) {
        return MatchedUser(
            id: data["id"].toString(),
            avatar: data["avatar"],
            username: data["username"],
            nickname: data["nickname"],
            email: data["email"],
            sex: data["sex"],
            birthday: string2DateTime(data["birthday"]),
            interest1: data["interest1"],
            interest2: data["interest2"],
            interest3: data["interest3"],
            last_location: data["last_location"].toString(),
            major: data["major"],
            intro: data["intro"],
            createTime: string2DateTime(data["createTime"]),
            updateTime: string2DateTime(data["updateTime"])
        );

      } else {}
    } else {}
  } catch (err) {
    debugPrint(err.toString());
  }
  return null;
}

Future getFriendId(String friendId) async {
  var data;
  try {
    var response = await http.get(Uri.parse("${domain}friend"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Token' : '${UserPreferences.getToken()}'
      },
    );
    if (response.statusCode == 200) {
      data = (jsonDecode(utf8.decode(response.bodyBytes)))["data"]["records"];
      // debugPrint(data.toString());
      if (data != null){
        for (int i = 0; i < data.length; i++) {
          if (data[i]["friendId"] == friendId) {
            return data[i]["id"];
          }
        }
      }
    }
  } catch (err) {
    debugPrint(err.toString());
  }
  return null;
}

Future getFriendList() async {
  friends.clear();
  var data;
  try {
    var response = await http.get(Uri.parse("${domain}friend"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Token' : '${UserPreferences.getToken()}'
      },
    );
    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
      if (data["data"]["records"] != null) {
        List e = data["data"]["records"];
        // debugPrint(e.toString());
        e.removeWhere((value) => value == null);
        // debugPrint(e.toString());
        for (int i = 0; i < e.length; i++) {
          MatchedUser matchedUser = await getUserDetailById(e[i]["friendId"]);
          friends.add(matchedUser);
        }
        // debugPrint(events.toString());
      } else {}
    } else {}
  } catch (err) {
    debugPrint(err.toString());
  }
  return friends;
}

Future getFriendMsgList(String fromUserId, String toUserId) async {
  friendMessages.clear();
  var data;
  try {
    final params = {
      "fromUserId": fromUserId,
      "toUserId": toUserId,
    };
    var response = await http.get(Uri.http('server_ip:8003', '/unimatch-api/friendMsg', params),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Token' : '${UserPreferences.getToken()}',
        },);
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["data"] != null) {
        List fm = data["data"]["records"];
        fm = fm.reversed.toList();
        // Create list of liked users
        for (int i = 0; i < fm.length; i++) {
          if (fm[i]["status"] != 2) {
            friendMessages.add(
                Message(
                  id: fm[i]["id"],
                  text: fm[i]["status"] != 1 ? fm[i]["msgContent"] : "This message was revoked!",
                  msgType: fm[i]["msgType"].toString(),
                  date: DateTime.parse(fm[i]["createTime"]),
                  isSentByClient: int.parse(fm[i]["fromUserId"]) == int.parse(clientUser.id) ? true : false,
                )
            );
          }
        }
        // debugPrint(friendMessages.length.toString());
      }
    }
  } catch (err) {
    debugPrint(err.toString());
  }
}

Future<bool> isGroupExistById(String groupId) async {
  //debugPrint(groupId.toString());
  var data;
  try {
    var response = await http.get(Uri.http('server_ip:8003', '/unimatch-api/group'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Token' : '${UserPreferences.getToken()}',
      },);
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["data"] != null) {
        List groups = data["data"]["records"];
        for (int i = 0; i < groups.length; i++) {
          if (groups[i]["id"].toString() == groupId) {
            return true;
          }
        }
      }
    }
  } catch (err) {
    debugPrint(err.toString());
  }
  return false;
}


Future getGroupMsgList(String toUserId) async {
  groupMessages.clear();
  var data;
  try {
    final params = {
      "groupId": toUserId,
    };
    var response = await http.get(Uri.http('server_ip:8003', '/unimatch-api/groupMsg', params),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Token' : '${UserPreferences.getToken()}',
      },);
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["data"] != null) {
        List gm = data["data"]["records"];
        gm = gm.reversed.toList();
        // Create list of liked users
        for (int i = 0; i < gm.length; i++) {
          if (gm[i]["status"] != 2) {
            groupMessages.add(
                Message(
                  id: gm[i]["id"],
                  senderName: gm[i]["fromUserNickname"],
                  text: gm[i]["status"] != 1 ? gm[i]["msgContent"] : "This message was revoked!",
                  msgType: gm[i]["msgType"].toString(),
                  date: DateTime.parse(gm[i]["createTime"]),
                  isSentByClient: int.parse(gm[i]["fromUserId"]) == int.parse(clientUser.id) ? true : false,
                )
            );
          }
        }
        // debugPrint(friendMessages.length.toString());
      }
    }
  } catch (err) {
    debugPrint(err.toString());
  }
}

Future getLocationUsers(String location, String distance) async {
  await updateUserLocation(location);
  locationMatchedUsers.clear();
  if (location == "0") {
    return;
  }
  var data;
  try {
    Map<String, String> params = {
      'locationCode' : location,
    };
    var response = await http.get(Uri.http('server_ip:8003', '/unimatch-api/match/location', params),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Token' : '${UserPreferences.getToken()}',
      },
    );
    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["data"]["records"] != null) {
        List users = data["data"]["records"];
        // Remove null users or non-setup users
        users.removeWhere((value) => value == null);
        users.removeWhere((value) => value["birthday"] == null);
        // debugPrint(users.length.toString());
        // Create list of matched users
        for (int i = 0; i < users.length; i++) {
          locationMatchedUsers.add(
              LocationUser(
                  id: users[i]["id"].toString(),
                  avatar: users[i]["avatar"],
                  username: users[i]["username"],
                  nickname: users[i]["nickname"],
                  email: users[i]["email"],
                  birthday: string2DateTime(users[i]["birthday"]),
                  intro: users[i]["intro"],
                  createTime: string2DateTime(users[i]["createTime"]),
                  updateTime: string2DateTime(users[i]["updateTime"]),
                  sex: users[i]["sex"].toString(),
                  interest1: users[i]["interest1"],
                  interest2: users[i]["interest2"],
                  interest3: users[i]["interest3"],
                  major: users[i]["major"],
                  distance: distance
              )
          );
        }
      } else {}
    } else {}
  } catch (err) {
    debugPrint(err.toString());
  }
  return locationMatchedUsers;
}

Future updateUserLocation(String location) async {
  var data;
    try {
      var response = await http.put(Uri.parse(updateURL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Access-Token' : '${UserPreferences.getToken()}',
          },
          body: jsonEncode(<String, String>{
            "id": clientUser.id,
            "username": clientUser.username,
            "nickname": clientUser.nickname,
            "avatar": clientUser.avatar,
            "email": clientUser.email,
            "sex": clientUser.sex,
            "birthday": dateTime2StringWithoutTime(clientUser.birthday),
            "intro": clientUser.intro,
            "major": clientUser.major.toString(),
            "interest1": clientUser.interest1.toString(),
            "interest2": clientUser.interest2.toString(),
            "interest3": clientUser.interest3.toString(),
            "last_location": location,
            "deleted": "",
            "token": UserPreferences.getToken() ?? "",
          }));
      // debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        data = jsonDecode(utf8.decode(response.bodyBytes));
        // debugPrint(data.toString());
        if (data["success"] == true) {
          // debugPrint("Updated User Location Code!");
        }
      }
    } catch (err) {
      debugPrint(err.toString());
    }
}

Future updateNickname(BuildContext context, TextEditingController teNickname) async {
  var data;
  if (teNickname.text == "") {
    showMsg(context, "Empty Fields!", Colors.red);
  } else {
    showLoadingCircle(context);
    try {
      // debugPrint(UserPreferences.getToken());
      var response = await http.put(Uri.parse(updateURL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Access-Token' : '${UserPreferences.getToken()}'
          },
          body: jsonEncode(<String, String>{
            "id": clientUser.id,
            "username": clientUser.username,
            "nickname": teNickname.text,
            "avatar": clientUser.avatar,
            "email": clientUser.email,
            "sex": clientUser.sex,
            "birthday": dateTime2StringWithoutTime(clientUser.birthday),
            "intro": clientUser.intro,
            "major": clientUser.major.toString(),
            "interest1": clientUser.interest1.toString(),
            "interest2": clientUser.interest2.toString(),
            "interest3": clientUser.interest3.toString(),
            "deleted": "",
            "token": UserPreferences.getToken() ?? "",
          }));
      // debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        Navigator.pop(context);
        data = jsonDecode(utf8.decode(response.bodyBytes));
        // debugPrint(data.toString());
        if (data["success"] == false) {
          showMsg(context, data["message"], Colors.red);
        } else {
          clientUser.nickname = teNickname.text;
          Navigator.pop(context);
          showMsg(context, "Update Successfully!", Colors.green);
        }
      } else {
        Navigator.pop(context);
        showMsg(context, "Update Failed!", Colors.red);
      }
    } catch (err) {
      showMsg(context, "Unknown Error!", Colors.red);
      debugPrint(err.toString());
    }
  }
}

Future updateIntro(BuildContext context, TextEditingController teIntro) async {
  var data;
  if (teIntro.text == "") {
    showMsg(context, "Empty Fields!", Colors.red);
  } else {
    showLoadingCircle(context);
    try {
      var response = await http.put(Uri.parse(updateURL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Access-Token' : '${UserPreferences.getToken()}',
          },
          body: jsonEncode(<String, String>{
            "id": clientUser.id,
            "username": clientUser.username,
            "nickname": clientUser.nickname,
            "avatar": clientUser.avatar,
            "email": clientUser.email,
            "sex": clientUser.sex,
            "birthday": dateTime2StringWithoutTime(clientUser.birthday),
            "intro": teIntro.text,
            "major": clientUser.major.toString(),
            "interest1": clientUser.interest1.toString(),
            "interest2": clientUser.interest2.toString(),
            "interest3": clientUser.interest3.toString(),
            "deleted": "",
            "token": UserPreferences.getToken() ?? "",
          }));
      // debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        Navigator.pop(context);
        data = jsonDecode(utf8.decode(response.bodyBytes));
        // debugPrint(data.toString());
        if (data["success"] == false) {
          showMsg(context, data["message"], Colors.red);
        } else {
          Navigator.pop(context);
          clientUser.intro = teIntro.text;
          showMsg(context, "Update Successfully!", Colors.green);
        }
      } else {
        Navigator.pop(context);
        showMsg(context, "Update Failed!", Colors.red);
      }
    } catch (err) {
      showMsg(context, "Unknown Error!", Colors.red);
      debugPrint(err.toString());
    }
  }
}

Future updateMajor(BuildContext context, String major) async {
  var data;
  showLoadingCircle(context);
  try {
    var response = await http.put(Uri.parse(updateURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Token' : '${UserPreferences.getToken()}',
        },
        body: jsonEncode(<String, String>{
          "id": clientUser.id,
          "username": clientUser.username,
          "nickname": clientUser.nickname,
          "avatar": clientUser.avatar,
          "email": clientUser.email,
          "sex": clientUser.sex,
          "birthday": dateTime2StringWithoutTime(clientUser.birthday),
          "intro": clientUser.intro,
          "major": FULL_PROGRAM_TYPES.indexOf(major).toString(),
          "interest1": clientUser.interest1.toString(),
          "interest2": clientUser.interest2.toString(),
          "interest3": clientUser.interest3.toString(),
          "deleted": "",
          "token": UserPreferences.getToken() ?? "",
        }));
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["success"] == false) {
        showMsg(context, data["message"], Colors.red);
      } else {
        clientUser.major = FULL_PROGRAM_TYPES.indexOf(major);
        showMsg(context, "Update Successfully!", Colors.green);
      }
    } else {
      showMsg(context, "Update Failed!", Colors.red);
    }
  } catch (err) {
    showMsg(context, "Unknown Error!", Colors.red);
    debugPrint(err.toString());
  }
}

Future updateInterest(BuildContext context, List<String> interests) async {
  var data;
  showLoadingCircle(context);
  // debugPrint(interests.toString());
  try {
    var response = await http.put(Uri.parse(updateURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Token' : '${UserPreferences.getToken()}',
        },
        body: jsonEncode(<String, String>{
          "id": clientUser.id,
          "username": clientUser.username,
          "nickname": clientUser.nickname,
          "avatar": clientUser.avatar,
          "email": clientUser.email,
          "sex": clientUser.sex,
          "birthday": dateTime2StringWithoutTime(clientUser.birthday),
          "intro": clientUser.intro,
          "major": clientUser.major.toString(),
          "interest1": interests.isEmpty ? "0" : FULL_INTERESTS.indexOf(interests[0]).toString(),
          "interest2": interests.length < 2 ? "0" : FULL_INTERESTS.indexOf(interests[1]).toString(),
          "interest3": interests.length < 3 ? "0" : FULL_INTERESTS.indexOf(interests[2]).toString(),
          "deleted": "",
          "token": UserPreferences.getToken() ?? "",
        }));
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["success"] == false) {
        showMsg(context, data["message"], Colors.red);
      } else {
        clientUser.interest1 = interests.isEmpty ? 0 : FULL_INTERESTS.indexOf(interests[0]);
        clientUser.interest2 = interests.length < 2 ? 0 : FULL_INTERESTS.indexOf(interests[1]);
        clientUser.interest3 = interests.length < 3 ? 0 : FULL_INTERESTS.indexOf(interests[2]);
        Navigator.pop(context);
        showMsg(context, "Update Successfully!", Colors.green);
      }
    } else {
      Navigator.pop(context);
      showMsg(context, "Update Failed!", Colors.red);
    }
  } catch (err) {
    showMsg(context, "Unknown Error!", Colors.red);
    debugPrint(err.toString());
  }
}

Future updatePwd(BuildContext context, TextEditingController teOldPwd, TextEditingController teNewPwdRepeat) async {
  var data;
  showLoadingCircle(context);
  try {
    var response = await http.put(Uri.parse("$updateURL/pwd"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Token' : '${UserPreferences.getToken()}',
        },
        body: jsonEncode(<String, String>{
          "oldPwd": teOldPwd.text,
          "newPwd": teNewPwdRepeat.text,
          "confirmPwd": teNewPwdRepeat.text,
        }));
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["success"] == false) {
        showMsg(context, data["message"], Colors.red);
      } else {
        Navigator.pushReplacementNamed(context, "/profile");
        showMsg(context, "Update Successfully!", Colors.green);
      }
    } else {
      Navigator.pop(context);
      showMsg(context, "Update Failed!", Colors.red);
    }
  } catch (err) {
    showMsg(context, "Unknown Error!", Colors.red);
    debugPrint(err.toString());
  }
}

Future<String> uploadFile(int type, File file) async {
  // 2 = Photo, 3 = Voice Msg, 4 = Video
  var data;
  var params = {
    'name': 'file',
    'filePath': file.path,
    'fileType': 'image'
  };
  try {
    var request = http.MultipartRequest('POST', Uri.parse("${domain}upload"));
    request.headers.addAll(<String,String>{
      //'Access-Token': '${UserPreferences.getToken()}',
    });
    request.fields.addAll(params);
    request.files.add(http.MultipartFile.fromBytes('file', File(file.path).readAsBytesSync(), filename: file.path.split('/').last));
    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      data = jsonDecode(responseString);
      // debugPrint(responseString);
      if (data["success"] == false) {
        debugPrint(data["message"]);
      } else {
        return "$domain${data["data"]["url"].substring(0)}";
        // updateAvatarUrl(context, "$domain${data["data"]["url"].substring(0)}");
      }
    } else {
      debugPrint("File Upload Failed!");
    }
  } catch (err) {
    debugPrint(err.toString());
  }
  return "";
}

Future<String> addGroup(String avatar, String title, String type, String notice, String description) async {
  var data;
  try {
    var response = await http.post(Uri.parse("${domain}group"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Token' : '${UserPreferences.getToken()}',
        },
        body: jsonEncode(<String, String>{
          "name": title,
          "avatar": avatar,
          "tag": type,
          "intro": description,
          "notice": notice
        }));
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["success"] == false) {
        return data["message"];
      } else {
        return data["success"].toString();
      }
    }
  } catch (err) {
    debugPrint(err.toString());
  }
  return "false";
}

Future<String> addEvent(String avatar, String title, String type, String notice, String description, String location, DateTime date, TimeOfDay time) async {
  var data;
  try {
    var response = await http.post(Uri.parse("${domain}group"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Token' : '${UserPreferences.getToken()}',
        },
        body: jsonEncode(<String, String>{
          "name": title,
          "avatar": avatar,
          "tag": type,
          "intro": description,
          "notice": notice,
          "groupeventlocation": location,
          "groupeventtime": individualDateTime2String(date, time)
        }));
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["success"] == false) {
        return data["message"];
      } else {
        return data["success"].toString();
      }
    }
  } catch (err) {
    debugPrint(err.toString());
  }
  return "false";
}

Future retrievePwd(BuildContext context, String username) async {
  var data;
  showLoadingCircle(context);
  try {
    var response = await http.post(Uri.parse("${domain}login/retrieve"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Token' : '${UserPreferences.getToken()}',
        },
        body: jsonEncode(<String, String>{
          "username": username,
        }));
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["success"] == false) {
        showMsg(context, data["message"], Colors.red);
        return false;
      } else {
        showMsg(context, "Email Sent Successfully!", Colors.green);
        return true;
      }
    } else {
      showMsg(context, "Email Sent Failed!", Colors.red);
      return false;
    }
  } catch (err) {
    showMsg(context, "Unknown Error!", Colors.red);
    debugPrint(err.toString());
    return false;
  }
}

Future joinGroupEvent(BuildContext context, String userId, String groupId) async {
  var data;
  showLoadingCircle(context);
  List groupEventUsersId = await getGroupEventUsersById(groupId);
  if (groupEventUsersId.any((val) => val == userId)) {
    Navigator.pop(context);
    showMsg(context, "You had already joined!", Colors.red);
    return false;
  }
  try {
    var response = await http.post(Uri.parse("${domain}group/join"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Token' : '${UserPreferences.getToken()}',
        },
        body: jsonEncode(<String, String>{
          "userIds": userId,
          "groupId": groupId,
        }));
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["success"] == false) {
        showMsg(context, data["message"], Colors.red);
        return false;
      } else {
        showMsg(context, "Joined Successfully!", Colors.green);
        return true;
      }
    } else {
      showMsg(context, "Join Failed!", Colors.red);
      return false;
    }
  } catch (err) {
    showMsg(context, "Unknown Error!", Colors.red);
    debugPrint(err.toString());
    return false;
  }
}

Future<String> updateUserAvatar(String url) async {
  var data;
  try {
    var response = await http.put(Uri.parse(updateURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Token' : '${UserPreferences.getToken()}',
        },
        body: jsonEncode(<String, String>{
          "id": clientUser.id,
          "username": clientUser.username,
          "nickname": clientUser.nickname,
          "avatar": url,
          "email": clientUser.email,
          "sex": clientUser.sex,
          "birthday": dateTime2StringWithoutTime(clientUser.birthday),
          "intro": clientUser.intro,
          "major": clientUser.major.toString(),
          "interest1": clientUser.interest1.toString(),
          "interest2": clientUser.interest2.toString(),
          "interest3": clientUser.interest3.toString(),
          "deleted": "",
          "token": UserPreferences.getToken() ?? "",
        }));
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["success"] == false) {
        return data["message"];
      } else {
        return data["success"].toString();
      }
    }
  } catch (err) {
    debugPrint(err.toString());
  }
  return "false";
}

bool isFileEmpty(BuildContext context, int type, File file) {
  if (file.isNull) {
    switch (type) {
      case 2: {
        showMsg(context, "No Image Selected!", Colors.red);
        return true;
      }
      case 4: {
        showMsg(context, "No Video Selected!", Colors.red);
        return true;
      }
    }
  }
  return false;
}

Future updateSetup(BuildContext context) async {
  var data;
  showLoadingCircle(context);
  try {
    var response = await http.put(Uri.parse(updateURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Token' : '${UserPreferences.getToken()}',
        },
        body: jsonEncode(<String, String>{
          "id": clientUser.id,
          "username": clientUser.username,
          "nickname": pendingNickname,
          "avatar": clientUser.avatar,
          "email": clientUser.email,
          "sex": (FULL_GENDER.indexOf(pendingSex) - 1).toString(),
          "birthday": dateTime2StringWithoutTime(pendingBirth),
          "intro": pendingIntro,
          "major": (FULL_PROGRAM_TYPES.indexOf(pendingProgramType)).toString(),
          "interest1": pendingInterest1.isEmpty ? "0" : (FULL_INTERESTS.indexOf(pendingInterest1)).toString(),
          "interest2": pendingInterest2.isEmpty ? "0" : (FULL_INTERESTS.indexOf(pendingInterest2)).toString(),
          "interest3": pendingInterest3.isEmpty ? "0" : (FULL_INTERESTS.indexOf(pendingInterest3)).toString(),
          "deleted": "",
          "token": UserPreferences.getToken() ?? "",
        }));
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = jsonDecode(utf8.decode(response.bodyBytes));
      // debugPrint(data.toString());
      if (data["success"] == false) {
        showMsg(context, data["message"], Colors.red);
      } else {
        Navigator.pushReplacementNamed(context, "/primary");
        clientUser.nickname = pendingNickname;
        clientUser.birthday = pendingBirth;
        clientUser.sex = (FULL_GENDER.indexOf(pendingSex) - 1).toString();
        clientUser.major = (FULL_PROGRAM_TYPES.indexOf(pendingProgramType));
        clientUser.interest1 = pendingInterest1.isEmpty ? 0 : (FULL_INTERESTS.indexOf(pendingInterest1));
        clientUser.interest2 = pendingInterest2.isEmpty ? 0 : (FULL_INTERESTS.indexOf(pendingInterest2));
        clientUser.interest3 = pendingInterest3.isEmpty ? 0 : (FULL_INTERESTS.indexOf(pendingInterest3));
        clientUser.intro = pendingIntro;
        resetPending();
        showMsgThenTutorial(context, "Profile Setup Successfully!", Colors.green);
      }
    } else {
      Navigator.pop(context);
      showMsg(context, "Profile Setup Failed!", Colors.red);
    }
  } catch (err) {
    showMsg(context, "Unknown Error!", Colors.red);
    debugPrint(err.toString());
  }
}

void resetPending() {
  pendingNickname = "";
  pendingSex = "--";
  pendingInterest1 = "";
  pendingInterest2 = "";
  pendingInterest3 = "";
  pendingProgramType = "--";
  pendingIntro = "";
  pendingBirth = DateTime.now();
}

String getConstellation(BuildContext context, DateTime birth) {
  int month = birth.month;
  int day = birth.day;
  String constellation = '';
  List<String> list = CONSTELLATIONS;
  switch (month) {
    case DateTime.january:
      constellation = day < 21 ? list[0] : list[1];
      break;
    case DateTime.february:
      constellation = day < 20 ? list[1] : list[2];
      break;
    case DateTime.march:
      constellation = day < 21 ? list[2] : list[3];
      break;
    case DateTime.april:
      constellation = day < 21 ? list[3] : list[4];
      break;
    case DateTime.may:
      constellation = day < 22 ? list[4] : list[5];
      break;
    case DateTime.june:
      constellation = day < 22 ? list[5] : list[6];
      break;
    case DateTime.july:
      constellation = day < 23 ? list[6] : list[7];
      break;
    case DateTime.august:
      constellation = day < 24 ? list[7] : list[8];
      break;
    case DateTime.september:
      constellation = day < 24 ? list[8] : list[9];
      break;
    case DateTime.october:
      constellation = day < 24 ? list[9] : list[10];
      break;
    case DateTime.november:
      constellation = day < 23 ? list[10] : list[11];
      break;
    case DateTime.december:
      constellation = day < 22 ? list[11] : list[0];
      break;
  }
  return constellation;
}

const mainColor = Colors.indigo;

Widget buildLoginSheet(BuildContext context, TextEditingController teUsername, TextEditingController tePwd) {
  RxBool isPwdVisible = false.obs;
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), // Handling Keyboard Movement
    child: Container(
      height: MediaQuery.of(context).size.height * 0.33,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("LOGIN", style: TextStyle(color: mainColor, fontSize: 20, fontWeight: FontWeight.bold),),
          const SizedBox(
            height: 10,
          ),
          TfOutlined(
            controller: teUsername,
            hint: "Username/ITSC Email",
            prefixIcon: Icon(Icons.person, color: Colors.indigo.shade600,),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(() => TfOutlined(
            controller: tePwd,
            hint: "Password",
            hideText: !isPwdVisible.value,
            prefixIcon: Icon(Icons.lock, color: Colors.indigo.shade600,),
            suffixIcon: GestureDetector(
                onLongPress: () {
                  isPwdVisible.value = true;
                },
                onLongPressEnd: (_) {
                  isPwdVisible.value = false;
                },
                child: Icon(Icons.visibility, color: Colors.indigo.shade600,)
            ),
          ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: btnNormal(
                name: "LOGIN",
                onTap: () async {
                  await signUserIn(context, teUsername, tePwd);

                }),
          ),
        ],
      ),
    ),
  );
}

Widget buildRegisterSheet(BuildContext context, TextEditingController teITSC) {
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), // Handling Keyboard Movement
    child: Container(
      height: MediaQuery.of(context).size.height * 0.33,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("REGISTER WITH ITSC", style: TextStyle(color: mainColor, fontSize: 20, fontWeight: FontWeight.bold),),
          const SizedBox(
            height: 10,
          ),
          TfOutlined(
            controller: teITSC,
            hint: "ITSC (Without @connect.ust.hk)",
            prefixIcon: Icon(Icons.email, color: Colors.indigo.shade600,),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: btnNormal(
                name: "REGISTER",
                onTap: () async {
                  await regUser(context, teITSC);
                }),
          ),
        ],
      ),
    ),
  );
}

Widget buildSingleTextInputSheet(BuildContext context, TextEditingController teController, IconData icon, String hint, Function() refresh) {
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), // Handling Keyboard Movement
    child: Container(
      height: MediaQuery.of(context).size.height * 0.2,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // const Text("REGISTER WITH ITSC", style: TextStyle(color: mainColor, fontSize: 20, fontWeight: FontWeight.bold),),
          TfOutlined(
            controller: teController,
            hint: hint,
            prefixIcon: Icon(icon, color: Colors.indigo.shade600,),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: btnNormal(
                name: "Save",
                onTap: () {
                  Navigator.pop(context);
                  refresh();
                }),
          ),
        ],
      ),
    ),
  );
}

Widget buildSingleOptionDialog(BuildContext context, String title, List<String> options, Function() onPressed) {
  return SimpleDialog(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    title: Text(title),
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          physics:
          const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (ctx, index) {
            return SimpleDialogOption(
              onPressed: onPressed,
              child: Center(
                child: Text(options[index]),
              ),
            );
          },
          itemCount: options.length,
        ),
      )
    ],
  );
}

Widget buildBottomSheet(BuildContext context, Function() refresh) {
  Future getImgFromSrc(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
        pendingSendImg = File(pickedFile.path);
        Navigator.pop(context);
        refresh();
    }
  }
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), // Handling Keyboard Movement
    child: Container(
      height: MediaQuery.of(context).size.height * 0.2,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async { // Gallery
                  await getImgFromSrc(ImageSource.gallery);
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.grey.shade400,
                ),
                child: const Icon(Icons.collections, color: Colors.blueAccent, size: 32,),
              ),
              Text("Gallery", style: TextStyle(color: Colors.indigo.shade600, fontSize: 16),),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async { // Camera
                  await getImgFromSrc(ImageSource.camera);
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.grey.shade400,
                ),
                child: const Icon(Icons.camera, color: Colors.white, size: 32,),
              ),
              Text("Camera", style: TextStyle(color: Colors.indigo.shade600, fontSize: 16),),
            ],
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     ElevatedButton(
          //       onPressed: () { // File
          //
          //       },
          //       style: ElevatedButton.styleFrom(
          //         shape: const CircleBorder(),
          //         padding: const EdgeInsets.all(16),
          //         backgroundColor: Colors.grey.shade400,
          //       ),
          //       child: const Icon(Icons.attach_file, color: Colors.blue, size: 32,),
          //     ),
          //     Text("File", style: TextStyle(color: Colors.indigo.shade600, fontSize: 16),),
          //   ],
          // ),
        ],
      ),
    ),
  );
}

Widget buildMultipleChoiceChipSheet(BuildContext context, TextEditingController teITSC) {
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), // Handling Keyboard Movement
    child: Container(
      height: MediaQuery.of(context).size.height * 0.33,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("REGISTER WITH ITSC", style: TextStyle(color: mainColor, fontSize: 20, fontWeight: FontWeight.bold),),
          const SizedBox(
            height: 10,
          ),
          TfOutlined(
            controller: teITSC,
            hint: "ITSC (Without @connect.ust.hk)",
            prefixIcon: Icon(Icons.email, color: Colors.indigo.shade600,),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: btnNormal(
                name: "REGISTER",
                onTap: () {
                  regUser(context, teITSC);
                }),
          ),
        ],
      ),
    ),
  );
}




showLoadingCircle(BuildContext context) {
  showDialog(
    context: context,
    builder: (builder) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white,),
      );
    },
  );
}

showMsg(BuildContext context, String msg, Color color) {
  return showDialog(
    context: context,
    builder: (builder) {
      return AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Center(
          child: Text(
            msg,
            style: TextStyle(color: color, fontSize: 20),
          ),
        ),
      );
    },
  );
}

showMsgThenTutorial(BuildContext context, String msg, Color color) {
  return showDialog(
    context: context,
    builder: (builder) {
      return AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Center(
          child: Text(
            msg,
            style: TextStyle(color: color, fontSize: 20),
          ),
        ),
      );
    },
  ).whenComplete(() {
    if (UserPreferences.getTutorial() == null) {
      showTutorial();
      UserPreferences.setTutorial(true);
    }
  });
}

void createTutorial(List<TargetFocus> targets) {
  tutorialCoachMark = TutorialCoachMark(
    targets: targets,
    colorShadow: Colors.indigo,
    textSkip: "SKIP",
    textStyleSkip: const TextStyle(letterSpacing: 5.0, color: Colors.white, fontSize: 20),
    paddingFocus: 5,
    opacityShadow: 0.7,
    imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
    onFinish: () {
    },
    onClickTarget: (target) {
      debugPrint('onClickTarget: $target');
    },
    onClickTargetWithTapPosition: (target, tapDetails) {
      debugPrint("target: $target");
      debugPrint(
          "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
    },
    onClickOverlay: (target) {
    },
    onSkip: () {
      return true;
    },
  );
}

void showTutorial() {
  tutorialCoachMark.show(context: currentContext);
}

DateTime string2DateTime(String s) {
  return DateTime.parse(s);
}

String dateTime2StringWithoutTime(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

String dateTime2String(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
}

String time2String(TimeOfDay time) {
  return time.toString().substring(10, 15);
}

String individualDateTime2String(DateTime date, TimeOfDay time) {
  return "${dateTime2StringWithoutTime(date)} ${time.toString().substring(10, 15)}:00";
}

String rssi2Distance(int rssi) {
  if (rssi >= -90) {
    return "100";
  }
  if (rssi >= -180) {
    return "200";
  }
  return "300";
}

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}

String string2Base64(String s) {
  return base64.encode(utf8.encode(s));
}

String base642String(String s) {
  return utf8.decode(base64.decode(s));
}