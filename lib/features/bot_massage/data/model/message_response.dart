class MessageResponse {
  bool? status;
  bool? workshopIs;
  String? response;

  MessageResponse({this.status, this.workshopIs, this.response});

  MessageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    workshopIs = json['workshop_is'];
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['workshop_is'] = this.workshopIs;
    data['response'] = this.response;
    return data;
  }
}
