import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DirectionsService {
  static Future<List<LatLng>> getDirections(
      LatLng origin, LatLng destination) async {
    const String apiKey =
        'AIzaSyA76s9cdGoREvd81WPf0yZOWdyiYJrTCFU'; // Replace with your Google API Key
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      debugPrint(json.decode(response.body));
      final data = json.decode(response.body);
      return _extractLatLngFromResponse(data);
    } else {
      throw Exception('Failed to load directions');
    }
  }

  static List<LatLng> _extractLatLngFromResponse(Map<String, dynamic> data) {
    List<LatLng> route = [];
    if (data['routes'].isNotEmpty) {
      var points = data['routes'][0]['overview_polyline']['points'];
      route = _decodePolyline(points);
    }
    return route;
  }

  static List<LatLng> _decodePolyline(String polyline) {
    List<LatLng> points = [];
    int index = 0, len = polyline.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result >> 1) ^ -(result & 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result >> 1) ^ -(result & 1);
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }
}