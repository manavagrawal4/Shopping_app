import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavourite = false,
  });
  Future<void> toggleFavouriteStatus(String? token, String? userId) async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final Uri url = Uri.parse(
        'https://shopping-app-76ce5-default-rtdb.firebaseio.com/userFavourites/$userId/$id.json?auth=$token');

    try {
      final response = await http.put(url,
          body: json.encode(
            isFavourite,
          ));
      if (response.statusCode >= 400) {
        isFavourite = oldStatus;
        notifyListeners();
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text('Error')));
      }
    } catch (e) {
      isFavourite = oldStatus;
      notifyListeners();
    }
  }
}
