class OrderModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  OrderModel({this.success, this.statusCode, this.message, this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
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
  String? user;
  List<Items>? items;
  int? totalAmount;
  String? status;
  Address? address;
  String? paymentMethod;
  String? paymentStatus;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.user,
      this.items,
      this.totalAmount,
      this.status,
      this.address,
      this.paymentMethod,
      this.paymentStatus,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    totalAmount = json['totalAmount'];
    status = json['status'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    paymentMethod = json['paymentMethod'];
    paymentStatus = json['paymentStatus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user'] = user;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['totalAmount'] = totalAmount;
    data['status'] = status;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['paymentMethod'] = paymentMethod;
    data['paymentStatus'] = paymentStatus;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Items {
  Product? product;
  int? quantity;
  String? size;
  List<Addons>? addons;
  int? price;

  Items({this.product, this.quantity, this.size, this.addons, this.price});

  Items.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    size = json['size'];
    if (json['addons'] != null) {
      addons = <Addons>[];
      json['addons'].forEach((v) {
        addons!.add(Addons.fromJson(v));
      });
    }
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['quantity'] = quantity;
    data['size'] = size;
    if (addons != null) {
      data['addons'] = addons!.map((v) => v.toJson()).toList();
    }
    data['price'] = price;
    return data;
  }
}

class Product {
  String? sId;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;

  Product({this.sId, this.name, this.image, this.createdAt, this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Addons {
  String? key;
  int? quantity;

  Addons({this.key, this.quantity});

  Addons.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['quantity'] = quantity;
    return data;
  }
}

class Address {
  String? street;
  String? city;
  String? state;
  String? zipCode;

  Address({this.street, this.city, this.state, this.zipCode});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['city'] = city;
    data['state'] = state;
    data['zipCode'] = zipCode;
    return data;
  }
}
