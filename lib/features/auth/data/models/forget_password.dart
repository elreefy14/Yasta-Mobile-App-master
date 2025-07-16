class ForgetPassWordModel {
  String? phone;
  String? token;
  String? password;
  String? passwordConfirmation;

  ForgetPassWordModel(
      {this.phone, this.token, this.password, this.passwordConfirmation});

  ForgetPassWordModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    token = json['token'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['token'] = this.token;
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    return data;
  }
}
