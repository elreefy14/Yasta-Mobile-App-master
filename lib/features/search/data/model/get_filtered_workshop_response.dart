class GetFilteredWorkshopResponse {
  bool? status;
  String? message;
  List<Data>? data;

  GetFilteredWorkshopResponse({this.status, this.message, this.data});

  GetFilteredWorkshopResponse.fromJson(Map<String, dynamic> json) {
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
  String? logo;
  String? name;
  String? address;
  dynamic rating;
  int? distance;

  Data(
      {this.id,
        this.logo,
        this.name,
        this.address,
        this.rating,
        this.distance});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'];
    name = json['name'];
    address = json['address'];
    rating = json['rating'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logo'] = this.logo;
    data['name'] = this.name;
    data['address'] = this.address;
    data['rating'] = this.rating;
    data['distance'] = this.distance;
    return data;
  }
}
