class UserModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  UserModel({this.success, this.statusCode, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? phone;
  String? role;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? name;
  String? img;
  String? email;

  Data(
      {this.sId,
      this.phone,
      this.role,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.name,
      this.img,
      this.email});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phone = json['phone'];
    role = json['role'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    name = json['name'];
    img = json['img'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['phone'] = phone;
    data['role'] = role;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['name'] = name;
    data['img'] = img;
    data['email'] = email;
    return data;
  }
}
