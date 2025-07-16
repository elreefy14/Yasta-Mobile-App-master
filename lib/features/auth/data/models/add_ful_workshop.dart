import 'dart:io';

import 'package:yasta/features/auth/data/models/add_socials_model.dart';

class WorkshopModel {
  String name;
  File imageFile; // Path to the main image file
  String address;
  String latitude;
  String longitude;
  String phone;
  String description;
  List<File> images;
  List<Socials> socials;// Paths to additional images

  WorkshopModel({
    required this.name,
    required this.imageFile,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.phone,
    required this.description,
    required this.images,
    required this.socials,
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
      'socials': socials,
    };
  }

  // Create a Workshop object from a JSON Map
  factory WorkshopModel.fromJson(Map<String, dynamic> json) {
    return WorkshopModel(
      name: json['name'],
      imageFile: json['image_file'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      phone: json['phone'],
      description: json['description'],
      socials: List<Socials>.from(json['socials']),
      images: List<File>.from(json['images']),
    );
  }
}
