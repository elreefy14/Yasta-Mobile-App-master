import 'package:yasta/features/auth/data/models/schedule_model.dart';

class WorkshopSchedulesRequestBody {
  List<ScheduleModel>? schedules;

  WorkshopSchedulesRequestBody({this.schedules});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.schedules != null) {
      data['schedules'] = this.schedules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Schedules {
  List<String>? dayWeek;
  String? openingTime;
  String? closingTime;

  Schedules({this.dayWeek, this.openingTime, this.closingTime});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day_week'] = this.dayWeek;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    return data;
  }
}
