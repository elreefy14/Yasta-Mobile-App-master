class AddWorkshopResponse {
  bool? status;
  String? message;
  Data? data;
  AddWorkshopResponse({this.status, this.message});

  AddWorkshopResponse.fromJson(Map<String, dynamic> json) {
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

  dynamic workshop_id;


  Data({
    this.workshop_id,
  });

  Data.fromJson(Map<String, dynamic> json) {

    workshop_id = json['workshop_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['workshop_id'] = workshop_id;

    return data;
  }
}
