class AddServicesModel {
  List<String>? services;

  AddServicesModel({this.services});

  AddServicesModel.fromJson(Map<String, dynamic> json) {
    services = json['services'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['services'] = this.services;
    return data;
  }
}
