class RestaurantDetailModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  RestaurantDetailModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  RestaurantDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? description;
  String? location;
  String? distance;
  String? cuisine;
  String? price;
  double? rating;
  String? mainImage;
  List<GalleryImages>? galleryImages;
  String? offer;
  List<WeeklyTimings>? weeklyTimings;
  List<MenuItems>? menuItems;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data({
    this.sId,
    this.name,
    this.description,
    this.location,
    this.distance,
    this.cuisine,
    this.price,
    this.rating,
    this.mainImage,
    this.galleryImages,
    this.offer,
    this.weeklyTimings,
    this.menuItems,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    location = json['location'];
    distance = json['distance'];
    cuisine = json['cuisine'];
    price = json['price'];
    rating = json['rating'];
    mainImage = json['mainImage'];
    if (json['galleryImages'] != null) {
      galleryImages = <GalleryImages>[];
      json['galleryImages'].forEach((v) {
        galleryImages!.add(GalleryImages.fromJson(v));
      });
    }
    offer = json['offer'];
    if (json['weeklyTimings'] != null) {
      weeklyTimings = <WeeklyTimings>[];
      json['weeklyTimings'].forEach((v) {
        weeklyTimings!.add(WeeklyTimings.fromJson(v));
      });
    }
    if (json['menuItems'] != null) {
      menuItems = <MenuItems>[];
      json['menuItems'].forEach((v) {
        menuItems!.add(MenuItems.fromJson(v));
      });
    }
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['location'] = location;
    data['distance'] = distance;
    data['cuisine'] = cuisine;
    data['price'] = price;
    data['rating'] = rating;
    data['mainImage'] = mainImage;
    if (galleryImages != null) {
      data['galleryImages'] = galleryImages!.map((v) => v.toJson()).toList();
    }
    data['offer'] = offer;
    if (weeklyTimings != null) {
      data['weeklyTimings'] = weeklyTimings!.map((v) => v.toJson()).toList();
    }
    if (menuItems != null) {
      data['menuItems'] = menuItems!.map((v) => v.toJson()).toList();
    }
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class GalleryImages {
  String? url;
  String? alt;

  GalleryImages({this.url, this.alt});

  GalleryImages.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['alt'] = alt;
    return data;
  }
}

class WeeklyTimings {
  String? day;
  String? hours;

  WeeklyTimings({this.day, this.hours});

  WeeklyTimings.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    hours = json['hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['hours'] = hours;
    return data;
  }
}

class MenuItems {
  String? id;
  String? title;
  String? description;
  String? price;
  String? category;
  String? image;

  MenuItems({
    this.id,
    this.title,
    this.description,
    this.price,
    this.category,
    this.image,
  });

  MenuItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    category = json['category'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['category'] = category;
    data['image'] = image;
    return data;
  }
}
