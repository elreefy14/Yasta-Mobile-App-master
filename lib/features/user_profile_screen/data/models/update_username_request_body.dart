import 'dart:io';

class UpdateUsernameRequestBody {
  String? firstName;
  String? lastName;
  File ?imageFile;
  UpdateUsernameRequestBody({this.firstName, this.lastName,this.imageFile});

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'image_file': imageFile,
    };
  }

  factory UpdateUsernameRequestBody.fromJson(Map<String, dynamic> json) {
    return UpdateUsernameRequestBody(
      firstName: json['first_name'],
      lastName: json['last_name'],
      imageFile: json['image_file'],
    );
  }
}
