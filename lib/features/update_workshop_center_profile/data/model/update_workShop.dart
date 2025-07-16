import 'dart:io';

class UpdateWorkshop {
  String? name;
  File? imageFile; // Path to the main image file
  String? address;

  String? phone;
  String? description;


  UpdateWorkshop({
     this.name,
     this.imageFile,
     this.address,
     this.phone,
     this.description,

  });

  // Convert the Workshop object to a Map for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image_file': imageFile,
      'address': address,
      'phone': phone,
      'description': description,

    };
  }

  // Create a Workshop object from a JSON Map
  factory UpdateWorkshop.fromJson(Map<String, dynamic> json) {
    return UpdateWorkshop(
      name: json['name'],
      imageFile: json['image_file'],
      address: json['address'],
      phone: json['phone'],
      description: json['description'],

    );
  }
}
