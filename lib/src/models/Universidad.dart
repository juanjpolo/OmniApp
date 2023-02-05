import 'dart:ffi';

class Universidad {
  // ignore: non_constant_identifier_names
  final String alpha_two_code;
  final List<String> domains;
  final String country;
  final String name;
  final String state_province;
  final List<String> web_pages;

  Universidad(
      {required this.alpha_two_code,
      required this.country,
      required this.domains,
      required this.name,
      required this.state_province,
      required this.web_pages});
}
