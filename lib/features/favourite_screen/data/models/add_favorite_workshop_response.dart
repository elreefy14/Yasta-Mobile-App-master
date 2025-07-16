class AddFavoriteWorkshopResponse {
  bool? status;
  String? message;
  Data? data;

  AddFavoriteWorkshopResponse({this.status, this.message, this.data});

  AddFavoriteWorkshopResponse.fromJson(Map<String, dynamic> json) {
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
  String? image;

  Workshop({this.id, this.name, this.image});

  Workshop.fromJson(Map<String, dynamic> json) {
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
