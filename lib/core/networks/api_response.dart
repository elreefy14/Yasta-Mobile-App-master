class ApiResponse {
  int? statusCode;
  Map<String, dynamic>? data;
  String? message;

  ApiResponse(this.statusCode, this.data, this.message);
}

