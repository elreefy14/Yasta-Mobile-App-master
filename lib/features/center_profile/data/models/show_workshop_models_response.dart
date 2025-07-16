class ShowWorkshopModelsResponse {
  bool? status;
  String? message;
  Data? data;

  ShowWorkshopModelsResponse({this.status, this.message, this.data});

  ShowWorkshopModelsResponse.fromJson(Map<String, dynamic> json) {
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
  Brands? brands;

  Data({this.brands});

  Data.fromJson(Map<String, dynamic> json) {
    brands =
    json['brands'] != null ? new Brands.fromJson(json['brands']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.brands != null) {
      data['brands'] = this.brands!.toJson();
    }
    return data;
  }
}

class Brands {
  Map<String, Honda>? brandData;

  Brands({this.brandData});

  Brands.fromJson(Map<String, dynamic> json) {
    brandData = json.map((key, value) => MapEntry(key, Honda.fromJson(value)));
  }

  Map<String, dynamic> toJson() {
    return brandData?.map((key, value) => MapEntry(key, value.toJson())) ?? {};
  }
}

class Honda {
  String? brandName;
  List<CarModels>? carModels;

  Honda({this.brandName, this.carModels});

  Honda.fromJson(Map<String, dynamic> json) {
    brandName = json['brand_name'];
    if (json['car_models'] != null) {
      carModels = <CarModels>[];
      json['car_models'].forEach((v) {
        carModels!.add(new CarModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_name'] = this.brandName;
    if (this.carModels != null) {
      data['car_models'] = this.carModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarModels {
  int? id;
  String? name;

  CarModels({this.id, this.name});

  CarModels.fromJson(Map<String, dynamic> json) {
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
