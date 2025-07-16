class RegisterRequestBody {
  String? firstName;
  String? lastName;
  String? phone;
  String? type;
  String? password;
  String? passwordConfirmation;

  RegisterRequestBody(
      {this.firstName,
        this.lastName,
        this.phone,
        this.type,
        this.password,
        this.passwordConfirmation});

  RegisterRequestBody.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    type = json['type'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    return data;
  }
}
