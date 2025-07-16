class GetMapWorkshopsResponse {
  bool? status;
  String? message;
  List<Data>? data;

  GetMapWorkshopsResponse({this.status, this.message, this.data});

  GetMapWorkshopsResponse.fromJson(Map<String, dynamic> json) {
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
  String? imageMaker;
  String? logo;
  String? image;
  String? name;
  String? address;
  dynamic rating;
  String? latitude;
  String? longitude;
  int? distance;

  Data(
      {this.id,
        this.imageMaker,
        this.logo,
        this.image,
        this.name,
        this.address,
        this.rating,
        this.latitude,
        this.longitude,
        this.distance});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageMaker = json['image_maker'];
    logo = json['logo'];
    image = json['image'];
    name = json['name'];
    address = json['address'];
    rating = json['rating'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_maker'] = this.imageMaker;
    data['logo'] = this.logo;
    data['image'] = this.image;
    data['name'] = this.name;
    data['address'] = this.address;
    data['rating'] = this.rating;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['distance'] = this.distance;
    return data;
  }
}
