class UserData {
  UserData();

  late final String API;
  late final String Description;
  late final String Auth;
  late final bool HTTPS;
  String? Cors;
  late final String Link;
  late final String Category;

  UserData.fromJson(Map<String, dynamic> json) {
    API = json['API'];
    Description = json['Description'];
    Auth = json['Auth'];
    HTTPS = json['HTTPS'];
    Cors = json['Cors'];
    Link = json['Link'];
    Category = json['Category'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['API'] = API;
    _data['Description'] = Description;
    _data['Auth'] = Auth;
    _data['HTTPS'] = HTTPS;
    _data['Cors'] = Cors;
    _data['Link'] = Link;
    _data['Category'] = Category;
    return _data;
  }
}
