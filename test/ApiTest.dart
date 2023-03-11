import 'package:entrando_en_ambiente/src/models/album_class.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class ApiProvider {
  final Client client;
  ApiProvider(this.client);

  Future<Album> getUser() async {
    const url = 'https://jsonplaceholder.typicode.com/photos/1';
    final uri = Uri.parse(url);
    final response = await client.get(uri);
    final responsejson = jsonDecode(response.body);
    final albumInfo = Album.fromJson(responsejson);
    return albumInfo;
  }
}
