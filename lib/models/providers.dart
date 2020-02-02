

class providers{
  final String pid;
  final String type;
  final String countLogins;
  final String title;
  final String name;
  final String mobile;
  final String pic;
  final String tel;


  providers(
      {this.pid,
        this.type,
        this.pic,
        this.tel,
        this.countLogins,
        this.title,
        this.name,
        this.mobile});

  factory providers.fromJson(Map<String, dynamic> json) {
    return providers(
        pid: json['pid'],
        type: json['type'],
        pic: json['pic'],
        tel: json['tel'],
        countLogins: json['countLogins'],
        title: json['title'],
        name: json['name'],
        mobile: json['mobile'],

    );
}
}