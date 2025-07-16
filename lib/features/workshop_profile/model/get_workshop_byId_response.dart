class GetWorkshopByIdResponse {
  bool? status;
  String? message;
  Data? data;

  GetWorkshopByIdResponse({this.status, this.message, this.data});

  GetWorkshopByIdResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? image;
  String? address;
  bool? checkFavorite;
  String? phone;
  dynamic rating;
  String? description;
  List<Images>? images;
  List<Services>? services;
  List<Socials>? socials;
  List<Brands>? brands;
  List<Schedule>? schedule;
  List<Reviews>? reviews;
  IsOpen? isOpen;


  Data(
      {this.id,
        this.name,
        this.rating,
        this.image,
        this.checkFavorite,
        this.address,
        this.phone,
        this.isOpen,
        this.description,
        this.images,
        this.services,
        this.socials,
        this.brands,
        this.schedule,
        this.reviews});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rating = json['rating'];
    image = json['image'];
    address = json['address'];
    checkFavorite = json['checkFavorite'];
    phone = json['phone'];
    isOpen =
    json['is_open'] != null ? new IsOpen.fromJson(json['is_open']) : null;
    description = json['description'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    if (json['socials'] != null) {
      socials = <Socials>[];
      json['socials'].forEach((v) {
        socials!.add(new Socials.fromJson(v));
      });
    }
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(new Brands.fromJson(v));
      });
    }
    if (json['schedule'] != null) {
      schedule = <Schedule>[];
      json['schedule'].forEach((v) {
        schedule!.add(new Schedule.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['checkFavorite'] = this.checkFavorite;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['description'] = this.description;
    if (this.isOpen != null) {
      data['is_open'] = this.isOpen!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.socials != null) {
      data['socials'] = this.socials!.map((v) => v.toJson()).toList();
    }
    if (this.brands != null) {
      data['brands'] = this.brands!.map((v) => v.toJson()).toList();
    }
    if (this.schedule != null) {
      data['schedule'] = this.schedule!.map((v) => v.toJson()).toList();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class IsOpen {
  bool? status;
  String? message;

  IsOpen({this.status, this.message});

  IsOpen.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
class Images {
  int? id;
  String? image;

  Images({this.id, this.image});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}

class Services {
  int? id;
  String? name;
  String? image;

  Services({this.id, this.name, this.image});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Socials {
  int? id;
  String? platform;
  String? url;

  Socials({this.id, this.platform, this.url});

  Socials.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    platform = json['platform'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['platform'] = this.platform;
    data['url'] = this.url;
    return data;
  }
}

class Brands {
  String? brandName;
  List<CarModels>? carModels;

  Brands({this.brandName, this.carModels});

  Brands.fromJson(Map<String, dynamic> json) {
    brandName = json['brand_name'];
    if (json['car_models'] != null) {
      carModels = <CarModels>[];
      json['car_models'].forEach((v) {
        carModels!.add(new CarModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_name'] = this.brandName;
    if (this.carModels != null) {
      data['car_models'] = this.carModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarModels {
  int? id;
  String? name;

  CarModels({this.id, this.name});

  CarModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Schedule {
  int? id;
  String? dayWeek;
  String? openingTime;
  String? closingTime;

  Schedule({this.id, this.dayWeek, this.openingTime, this.closingTime});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dayWeek = json['day_week'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day_week'] = this.dayWeek;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    return data;
  }
}

class Reviews {
  int? id;
  int? userId;
  String? username;
  String? userImage;
  int? rate;
  String? comment;
  String? created_at;

  Reviews(
      {this.id,
        this.userId,
        this.username,
        this.created_at,
        this.userImage,
        this.rate,
        this.comment});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    username = json['username'];
    userImage = json['user_image'];
    created_at = json['created_at'];
    rate = json['rate'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['created_at'] = this.created_at;
    data['user_image'] = this.userImage;
    data['rate'] = this.rate;
    data['comment'] = this.comment;
    return data;
  }
}
