class AddModelsModel {
  List<String>? models;

  AddModelsModel({this.models});

  AddModelsModel.fromJson(Map<String, dynamic> json) {
    models = json['models'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['models'] = this.models;
    return data;
  }
}
