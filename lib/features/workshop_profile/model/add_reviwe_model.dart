class AddReviewsModel {
  String? workshopId;
  String? rate;
  String? comment;

  AddReviewsModel({this.workshopId, this.rate, this.comment});

  AddReviewsModel.fromJson(Map<String, dynamic> json) {
    workshopId = json['workshop_id'];
    rate = json['rate'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['workshop_id'] = this.workshopId;
    data['rate'] = this.rate;
    data['comment'] = this.comment;
    return data;
  }
}
