class SystemUserModel {
  String? id;
  String? name;
  String? email;
  String? password;
  String? type;

  SystemUserModel({this.id, this.name, this.email, this.password, this.type});

  SystemUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['type'] = type;
    return data;
  }

  SystemUserModel.initial() {
    id = "";
  }
}
