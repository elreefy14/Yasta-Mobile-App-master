class ShowWorkshopSchedulesResponse {
  bool? status;
  String? message;
  List<Schedule>? data;

  ShowWorkshopSchedulesResponse({this.status, this.message, this.data});

  ShowWorkshopSchedulesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Schedule>[];
      json['data'].forEach((v) {
        data!.add(new Schedule.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Schedule {
  int? id;
  String? dayWeek;
  String? openingTime;
  String? closingTime;

  Schedule({this.id, this.dayWeek, this.openingTime, this.closingTime});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dayWeek = json['day_week'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day_week'] = this.dayWeek;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    return data;
  }
}
