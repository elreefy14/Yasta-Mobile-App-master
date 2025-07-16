
class VerifyResponse {
  bool? status;
  String? message;
  Data? data;

  VerifyResponse({this.status, this.message, this.data});

  VerifyResponse.fromJson(Map<String, dynamic> json) {
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
  String? token;
  String? type;
  String? phone;
  String? firstName;
  String? lastName;
  dynamic location;
  dynamic workshop_id;
  dynamic id;
  String? image;

  Data(
      {
        this.token,
        this.type,
        this.firstName,
        this.id,
        this.phone,
        this.lastName,
        this.location,
        this.workshop_id,
        this.image,
      });

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    type = json['type'];
    id = json['id'];
    phone = json['phone'];
    firstName = json['first_name'];
    workshop_id = json['workshop_id'];
    lastName = json['last_name'];
    location = json['location'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['type'] = this.type;
    data['first_name'] = this.firstName;
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['last_name'] = this.lastName;
    data['location'] = this.location;
    data['image'] = this.image;
    return data;
  }
}
