class GetFavoriteWorkshopsResponse {
  bool? status;
  String? message;
  List<Data>? data;

  GetFavoriteWorkshopsResponse({this.status, this.message, this.data});

  GetFavoriteWorkshopsResponse.fromJson(Map<String, dynamic> json) {
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
  Workshop? workshop;

  Data({this.id, this.workshop});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workshop = json['workshop'] != null
        ? new Workshop.fromJson(json['workshop'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.workshop != null) {
      data['workshop'] = this.workshop!.toJson();
    }
    return data;
  }
}

class Workshop {
  int? id;
  String? name;
  dynamic image;
  String? address;
  Images? images;
  dynamic distance;
  dynamic rating;

  Workshop(
      {this.id,
        this.name,
        this.image,
        this.address,
        this.images,
        this.rating,
        this.distance});

  Workshop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    address = json['address'];
    images =
    json['images'] != null ? new Images.fromJson(json['images']) : null;
    distance = json['distance'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['address'] = this.address;
    data['rating'] = this.rating;
    if (this.images != null) {
      data['images'] = this.images!.toJson();
    }
    data['distance'] = this.distance;
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
