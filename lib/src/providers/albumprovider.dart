import 'package:entrando_en_ambiente/src/models/album_class.dart';
import 'package:flutter/foundation.dart';

import '../services/handlerErrors.dart';
import '../services/services.dart';

enum ProductState { initial, loading, loaded, empty, error }

class AlbumProvider extends ChangeNotifier {
  final _service = ApiServices();
  int _itemCount = 10;
  List<Album> _albumsAux = [];
  List<Album> _albums = [];

  List<Album> get albums => _albums;
  int get itemCount => _itemCount;
  AppException _appException = AppException("", "", 200);
  ProductState _productState = ProductState.initial;

  AlbumProvider() {
    getAllTodos();
  }

  Future<void> getAllTodos() async {
    try {
      _setState(ProductState.loading);

      final List<Album> response = await _service.getAll();
      _albumsAux = response;
      _albums = response.sublist(0, itemCount);

      _setState(ProductState.loaded);

      notifyListeners();
    } on AppException catch (appException) {
      _setFailure(appException);
    }
  }

  ProductState get state => _productState;

  _setState(ProductState value) {
    _productState = value;
    notifyListeners();
  }

  void pagination() {
    _itemCount = itemCount + 10;
    _albumsAux.sublist(0, itemCount);
    _albums = _albumsAux;
    notifyListeners();
  }

  AppException get failure => _appException;
  _setFailure(AppException value) {
    _appException = value;
    _setState(ProductState.error);
  }
}
