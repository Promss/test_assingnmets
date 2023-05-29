import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test_assignments/models/item.dart';
import 'package:http/http.dart' as http;


class ItemListProvider with ChangeNotifier {
  List<Item> _items = [];
  bool _isLoading = false;

  List<Item> get items => _items;
  bool get isLoading => _isLoading;

  Future<void> fetchItems() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        _items = responseData.map((itemData) => Item.fromJson(itemData)).toList();
      }
    } catch (e) {
      print('Error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addItem(Item newItem) async {
    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: newItem.toJson(),
      );
      if (response.statusCode == 201) {
        final dynamic responseData = jsonDecode(response.body);
        final addedItem = Item.fromJson(responseData);
        _items.add(addedItem);
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> deleteItem(Item item) async {
    try {
      final response = await http.delete(Uri.parse('https://jsonplaceholder.typicode.com/posts/${item.id}'));
      if (response.statusCode == 200) {
        _items.remove(item);
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}