import 'dart:io';

class Workshop {
  String name;
  File imageFile; // Path to the main image file
  String address;
  String latitude;
  String longitude;
  String phone;
  String description;
  List<File> images; // Paths to additional images

  Workshop({
    required this.name,
    required this.imageFile,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.phone,
    required this.description,
    required this.images,
  });

  // Convert the Workshop object to a Map for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image_file': imageFile,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'phone': phone,
      'description': description,
      'images': images,
    };
  }

  // Create a Workshop object from a JSON Map
  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
      name: json['name'],
      imageFile: json['image_file'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      phone: json['phone'],
      description: json['description'],
      images: List<File>.from(json['images']),
    );
  }
}
