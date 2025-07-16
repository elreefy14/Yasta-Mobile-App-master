class VerifyUpdatedPhoneNumberRequestBody {
  String? otp;
  String? phone;

  VerifyUpdatedPhoneNumberRequestBody({this.otp, this.phone});

  VerifyUpdatedPhoneNumberRequestBody.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['phone'] = this.phone;
    return data;
  }
}
