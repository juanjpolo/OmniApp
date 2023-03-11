import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show  Request, Response;
import 'package:http/testing.dart';

import 'ApiTest.dart';

void main() {
  // ...

  test('test 1', () async {
    Future<Response> _mockRequest(Request request) async {
      final response = {
        "albumId": 1,
        "id": 1,
        "title": "accusamus beatae ad facilis cum similique qui sunt",
        "url": "https://via.placeholder.com/600/92c952",
        "thumbnailUrl": "https://via.placeholder.com/150/92c952"
      };
      return http.Response(jsonEncode(response), 200, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
    }
    

    final apiProvider = ApiProvider(MockClient(_mockRequest ));
    final album = await apiProvider.getUser();
    expect(album.id, 1);
    expect(album.albumId, 1);
    expect(
      album.title,
      'accusamus beatae ad facilis cum similique qui sunt',
    );
    expect(
      album.thumbnailUrl,
      "https://via.placeholder.com/150/92c952",
    );
  });
}
