class StartConversationsModel {
  int? workshopId;

  StartConversationsModel({this.workshopId});

  StartConversationsModel.fromJson(Map<String, dynamic> json) {
    workshopId = json['workshop_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['workshop_id'] = this.workshopId;
    return data;
  }
}
