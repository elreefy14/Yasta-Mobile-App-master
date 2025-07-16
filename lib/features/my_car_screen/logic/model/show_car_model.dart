class ShowCarResponse {
  bool? status;
  String? message;
  List<Data>? data;

  ShowCarResponse({this.status, this.message, this.data});

  ShowCarResponse.fromJson(Map<String, dynamic> json) {
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
  Brand? brand;
  Brand? model;
  Year? year;

  Data({this.id, this.brand, this.model, this.year});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    model = json['model'] != null ? new Brand.fromJson(json['model']) : null;
    year = json['year'] != null ? new Year.fromJson(json['year']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    if (this.model != null) {
      data['model'] = this.model!.toJson();
    }
    if (this.year != null) {
      data['year'] = this.year!.toJson();
    }
    return data;
  }
}

class Brand {
  int? id;
  String? name;

  Brand({this.id, this.name});

  Brand.fromJson(Map<String, dynamic> json) {
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

class Year {
  int? id;
  String? year;

  Year({this.id, this.year});

  Year.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['year'] = this.year;
    return data;
  }
}
