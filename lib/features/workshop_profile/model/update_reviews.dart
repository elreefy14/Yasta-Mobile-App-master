class UpdateReviews {
  String? rate;
  String? comment;

  UpdateReviews({this.rate, this.comment});

  UpdateReviews.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    data['comment'] = this.comment;
    return data;
  }
}
