class MessageWorkShopResponse {
  bool? status;
  bool? workshopIs;
  Response? response;

  MessageWorkShopResponse({this.status, this.workshopIs, this.response});

  MessageWorkShopResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    workshopIs = json['workshop_is'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['workshop_is'] = this.workshopIs;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  dynamic id;
  String? logo;
  String? image;
  String? name;
  String? address;
  dynamic rating;
  dynamic distance;

  Response(
      {this.id,
        this.logo,
        this.image,
        this.name,
        this.address,
        this.rating,
        this.distance});

  Response.fromJson(Map<String, dynamic> json) {
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
