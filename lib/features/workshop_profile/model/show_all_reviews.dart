class ShowAllReviewsResponseModel {
  bool? status;
  String? message;
  Data? data;

  ShowAllReviewsResponseModel({this.status, this.message, this.data});

  ShowAllReviewsResponseModel.fromJson(Map<String, dynamic> json) {
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
  Workshop? workshop;
  List<Reviews>? reviews;

  Data({this.workshop, this.reviews});

  Data.fromJson(Map<String, dynamic> json) {
    workshop = json['workshop'] != null
        ? new Workshop.fromJson(json['workshop'])
        : null;
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.workshop != null) {
      data['workshop'] = this.workshop!.toJson();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Workshop {
  String? name;
  String? logo;
  dynamic rating;

  Workshop({this.name, this.logo, this.rating});

  Workshop.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logo = json['logo'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['rating'] = this.rating;
    return data;
  }
}

class Reviews {
  int? id;
  String? username;
  String? userImage;
  dynamic rate;
  dynamic userId;
  String? comment;
  String? created_at;

  Reviews(
      {this.id,
        this.username,
        this.userImage,
        this.rate,
        this.userId,
        this.comment,
        this.created_at});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['user_name'];
    userImage = json['user_image'];
    rate = json['rate'];
    userId = json['user_id'];
    comment = json['comment'];
    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.username;
    data['user_id'] = this.userId;
    data['user_image'] = this.userImage;
    data['rate'] = this.rate;
    data['comment'] = this.comment;
    data['created_at'] = this.created_at;
    return data;
  }
}
