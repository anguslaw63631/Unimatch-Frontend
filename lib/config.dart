// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:get/get.dart';
import 'package:unimatch/prefabs/matchedUserCard.dart';
import 'package:unimatch/templates/LocationUser.dart';
import 'package:unimatch/templates/Message.dart';
import 'package:unimatch/templates/chatFriend.dart';
import 'package:unimatch/templates/event.dart';
import 'package:unimatch/templates/group.dart';
import 'package:unimatch/templates/likedUser.dart';
import 'package:unimatch/templates/matchedUser.dart';

RxString langCode = "en".obs;
List<MatchedUser> matchedUsers = [];
List<MatchedUserCard> matchedUserCards = [];
List<Message> friendMessages = [];
List<Message> groupMessages = [];
List<ChatFriend> chatFriends = [];
List<LikedUser> likedUsers = [];
List<LocationUser> locationMatchedUsers = [];
List<SingleEvent> events = [];
List<SingleGroup> groups = [];
List<MatchedUser> friends = [];
MatchedUser clientUser = MatchedUser(
  id: '',
  avatar: "https://static.vecteezy.com/system/resources/previews/005/544/718/original/profile-icon-design-free-vector.jpg",
  username: '',
  nickname: '',
  email: '',
  sex: '',
  birthday: DateTime.now(),
  interest1: 0,
  interest2: 0,
  interest3: 0,
  major: 0,
  intro: '',
  createTime: DateTime.now(),
  updateTime: DateTime.now(),
  last_location: '',
);
int userDistrict = 0;
//int userSchool = -1;
int userEducationLevel = 0;
int eventType = 0;
int eventDistrict = 0;
int eventTime = 0;
String eventDesc = "Anyone want to play Apex Legends?";
int userMBTI = 0;
// Profile Setup
DateTime pendingBirth = DateTime.now();
String pendingSex = "--";
String pendingNickname = "";
String pendingInterest1 = "";
String pendingInterest2 = "";
String pendingInterest3 = "";
String pendingProgramType = "--";
String pendingIntro = "";
File? pendingProfileAvatar;
// End Profile Setup
RxBool isLogged = false.obs;

File? pendingEventAvatar;
File? pendingGroupAvatar;
File? pendingSendImg;
