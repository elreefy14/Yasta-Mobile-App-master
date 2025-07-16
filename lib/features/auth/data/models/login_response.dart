class LoginResponse {
  bool? status;
  String? message;
  Data? data;

  LoginResponse({this.status, this.message, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  String? type;
  String? firstName;
  String? lastName;
  dynamic location;
  dynamic workshop_id;
  dynamic id;
  String? image;

  Data(
      {this.token,
        this.type,
        this.firstName,
        this.lastName,
        this.workshop_id,
        this.id,
        this.location,
        this.image});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    type = json['type'];
    id = json['id'];
    workshop_id = json['workshop_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    location = json['location'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['type'] = type;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['location'] = location;
    data['id'] = id;
    data['workshop_id'] = workshop_id;
    data['image'] = image;
    return data;
  }
}
