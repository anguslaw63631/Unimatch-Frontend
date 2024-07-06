class LocationUser {
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
  int major;
  String intro;
  DateTime createTime;
  DateTime updateTime;
  String distance;

  LocationUser({
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
    required this.major,
    required this.intro,
    required this.createTime,
    required this.updateTime,
    required this.distance,

  });

  int getId() {
    return int.parse(id);
  }

}