class AddCarRequestBody {
  int? yearId;

  AddCarRequestBody({this.yearId});

  AddCarRequestBody.fromJson(Map<String, dynamic> json) {
    yearId = json['year_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year_id'] = this.yearId;
    return data;
  }
}
