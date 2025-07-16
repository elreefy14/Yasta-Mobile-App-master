class SeenMessage<T> {
  bool? status;
  String? message;
  List<T>? data;

  SeenMessage({this.status, this.message, this.data});

  factory SeenMessage.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    return SeenMessage(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? List<T>.from(json['data'].map((item) => fromJson(item)))
          : null,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJson) {
    return {
      'status': status,
      'message': message,
      'data': data?.map((item) => toJson(item)).toList(),
    };
  }
}
