class MatchedUser {
  String id;
  String username;
  String nickname;
  String avatar;
  String email;
  String sex;
  DateTime birthday;
  int interest1;
  int interest2;
  int interest3;
  String last_location;
  int major;
  String intro;
  DateTime createTime;
  DateTime updateTime;

  MatchedUser({
    required this.id,
    required this.avatar,
    required this.username,
    required this.nickname,
    required this.email,
    required this.sex,
    required this.birthday,
    required this.interest1,
    required this.interest2,
    required this.interest3,
    required this.last_location,
    required this.major,
    required this.intro,
    required this.createTime,
    required this.updateTime
  });

  int getId() {
    return int.parse(id);
  }

}