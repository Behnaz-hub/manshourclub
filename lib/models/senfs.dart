

class Senf {
  final String aid;
  final String gid;
  final String maxLoan;
  final String numInstallments;
  final String name;
  final String details;
  final String pic;
  final String icon;

  Senf(
      {this.aid,
      this.gid,
      this.maxLoan,
      this.numInstallments,
      this.name,
      this.details,
      this.pic,
      this.icon});

  factory Senf.fromJson(Map<String, dynamic> json) {
    return Senf(
        aid: json['aid'],
        gid: json['gid'],
        maxLoan: json['maxLoan'],
        numInstallments: json['numInstallments'],
        name: json['name'],
        details: json['details'],
        pic: json['pic'],
        icon: json['icon']);
  }

//  static Resource<List<Senf>> get all {
//    return Resource(
//        url: "https://manshourclub.com/API/Loans/AllSenf.php",
//        parse: (response) {
//          final result = json.decode(response.body);
//          Iterable list = result['articles'];
//          print(list);
//          return list.map((model) => Senf.fromJson(model)).toList();
//        });
//  }
}
