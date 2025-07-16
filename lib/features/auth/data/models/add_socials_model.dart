class AddSocialsModel {
  List<Socials>? socials;

  AddSocialsModel({this.socials});

  AddSocialsModel.fromJson(Map<String, dynamic> json) {
    if (json['socials'] != null) {
      socials = <Socials>[];
      json['socials'].forEach((v) {
        socials!.add(new Socials.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.socials != null) {
      data['socials'] = this.socials!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Socials {
  String? platform;
  String? url;

  Socials({this.platform, this.url});

  Socials.fromJson(Map<String, dynamic> json) {
    platform = json['platform'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['platform'] = this.platform;
    data['url'] = this.url;
    return data;
  }
}
