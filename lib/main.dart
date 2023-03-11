import 'package:entrando_en_ambiente/src/providers/albumprovider.dart';
import 'package:entrando_en_ambiente/src/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AlbumProvider>(
      create: (_) => AlbumProvider(),
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Omni Test',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomePage()),
    );
  }
}
