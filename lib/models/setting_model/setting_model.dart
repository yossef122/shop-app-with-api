class UserDataSetting {
  bool? status;
  Data? data;


  UserDataSetting.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = /*json['data'] != null ?*/ new Data.fromJson(json['data']) /*: null*/;
  }
}

class Data {
  int? id;
  late  String name;
  late  String email;
  late String phone;
  String? image;
  String? token;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
  }

}