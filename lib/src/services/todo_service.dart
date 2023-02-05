import 'dart:convert';

import 'package:entrando_en_ambiente/src/models/Universidad.dart';
import 'package:http/http.dart' as http;

class TodoService {
  Future<List<Universidad>> getAll() async {
    const url =
        'https://tyba-assets.s3.amazonaws.com/FE-Engineer-test/universities.json';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final universidades = json.map((e) {
        return Universidad(
          alpha_two_code: e['alpha_two_code'],
          country: e['country'],
          domains: (e['domains'] as List).map((e) => e as String).toList(),
          name: e['name'],
          state_province: e['state-province'] ?? '',
          web_pages: (e['web_pages'] as List).map((e) => e as String).toList(),
        );
      }).toList();

      return universidades;
    }
    return [];
  }
}
