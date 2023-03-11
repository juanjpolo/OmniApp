import 'dart:io';

import 'package:entrando_en_ambiente/src/models/album_class.dart';
import 'package:http/http.dart' as http;

import '../helpers/services_errors_helper.dart';
import 'handlerErrors.dart';

class ApiServices {
  Future<List<Album>> getAll() async {
    List<Album> albumInfo;

    try {
      const url = 'https://jsonplaceholder.typicode.com/photos';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final responsejson = returnResponse(response);

      albumInfo = responsejson.map<Album>((e) {
        return Album(
          albumId: e['albumId'] ?? '',
          id: e['id'] ?? '',
          thumbnailUrl: e['thumbnailUrl'] ?? '',
          title: e['title'] ?? '',
          url: e['url-province'] ?? '',
        );
      }).toList();
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return albumInfo;
  }
}
