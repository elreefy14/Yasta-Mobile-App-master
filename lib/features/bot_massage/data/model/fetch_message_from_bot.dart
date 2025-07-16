class FetchMessageFromBot {
  bool? status;
  String? message;

  List<Data>? data;

  FetchMessageFromBot({this.status, this.message, this.data,});

  FetchMessageFromBot.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? senderType;
  bool? workshopIs;
  Response? response;
  String? createdAt;

  Data(
      {this.id,
        this.senderType,
        this.workshopIs,
        this.response,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderType = json['sender_type'];
    workshopIs = json['workshop_is'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_type'] = this.senderType;
    data['workshop_is'] = this.workshopIs;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Response {
  String? message;
  dynamic id;
  String? logo;
  String? image;
  String? name;
  String? address;
  dynamic rating;
  dynamic distance;

  Response(
      {this.message,
        this.id,
        this.logo,
        this.image,
        this.name,
        this.address,
        this.rating,
        this.distance});

  Response.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    id = json['id'];
    logo = json['logo'];
    image = json['image'];
    name = json['name'];
    address = json['address'];
    rating = json['rating'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['id'] = this.id;
    data['logo'] = this.logo;
    data['image'] = this.image;
    data['name'] = this.name;
    data['address'] = this.address;
    data['rating'] = this.rating;
    data['distance'] = this.distance;
    return data;
  }
}
