import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Product> _products = [];
  List<String> _categories = [];
  String _selectedCategory = '';
  bool _isLoading = false;
  String _error = '';

  List<Product> get products => _products;
  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchProducts() async {
    _setLoading(true);
    try {
      _products = await _apiService.getProducts();
      _error = '';
    } catch (e) {
      _error = 'Failed to fetch products: $e';
    }
    _setLoading(false);
  }

  Future<void> fetchCategories() async {
    _setLoading(true);
    try {
      _categories = await _apiService.getCategories();
      _error = '';
    } catch (e) {
      _error = 'Failed to fetch categories: $e';
    }
    _setLoading(false);
  }

  Future<void> filterByCategory(String category) async {
    if (category == _selectedCategory) return;

    _setLoading(true);
    _selectedCategory = category;

    try {
      if (category.isEmpty) {
        await fetchProducts();
      } else {
        _products = await _apiService.getProductsByCategory(category);
      }
      _error = '';
    } catch (e) {
      _error = 'Failed to filter products: $e';
    }
    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
