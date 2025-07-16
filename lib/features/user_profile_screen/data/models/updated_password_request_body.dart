class UpdatedPasswordRequestBody {
  String? passwordCurrent;
  String? password;
  String? passwordConfirmation;

  UpdatedPasswordRequestBody(
      {this.passwordCurrent, this.password, this.passwordConfirmation});

  UpdatedPasswordRequestBody.fromJson(Map<String, dynamic> json) {
    passwordCurrent = json['password_current'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password_current'] = this.passwordCurrent;
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    return data;
  }
}
