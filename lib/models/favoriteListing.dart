import 'package:flutter/material.dart';

class FavoriteListingModel with ChangeNotifier {
  final String id, listingId;

  FavoriteListingModel({required this.id, required this.listingId});
}
