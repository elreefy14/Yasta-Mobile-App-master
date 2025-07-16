class ScheduleModel {
  late List<String> dayWeek;
  late String openingTime;
  late String closingTime;

  ScheduleModel(
      {required this.dayWeek,
      required this.openingTime,
      required this.closingTime});

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    dayWeek = json['day_week'].cast<String>();
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
  }
  @override
  String toString() {
    return 'ScheduleModel(dayWeek: $dayWeek, openingTime: $openingTime, closingTime: $closingTime)';
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day_week'] = this.dayWeek;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    return data;
  }
}
