import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '/services/globals.dart';
import 'package:http/http.dart' as http;
import '../services/api_keys.dart';

class LocationHelper {
  static String generateLocationPreviewImage({
    double latitude,
    double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=${APIkeys.GOOGLE_API_KEY}';
  }

  static Future<String> getPlaceAddress(
      double latitude, double longitude) async {
    String address = "No address available";
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=${APIkeys.GOOGLE_API_KEY}';
    try {
      final response = await http.get(Uri.parse(url));
      address = json.decode(response.body)['results'][0]['formatted_address'];
    } on SocketException {
      snackbarKey.currentState
          ?.showSnackBar(SnackBar(content: Text("No Internet connection!")));
    } on HttpException {
      snackbarKey.currentState?.showSnackBar(
          SnackBar(content: Text("Couldn't find the requested data!")));
    } on FormatException {
      snackbarKey.currentState
          ?.showSnackBar(SnackBar(content: Text("Bad response format!")));
    }
    return address;
  }
}
