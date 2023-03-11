import 'package:entrando_en_ambiente/src/providers/albumprovider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../components/cardImage.dart';
import '../models/album_class.dart';

import '../components/ErrorComponent.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _TodoPage();
}

class _TodoPage extends State<HomePage> {
  final controller = ScrollController();
  @override
  void initState() {
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        Provider.of<AlbumProvider>(context, listen: false).pagination();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(231, 232, 244, 1),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Omni"),
      ),
      body: Consumer<AlbumProvider>(builder: (context, albumProvider, child) {
        switch (albumProvider.state) {
          case ProductState.loading:
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          case ProductState.loaded:
            return _buildList(albumProvider.albums);
          case ProductState.error:
            return ErrorContainer(
              context: context,
              img: 'assets/apierrorImage.webp',
              title: albumProvider.failure.prefix,
              message: albumProvider.failure.message,
              buttonText: 'Inténtalo de nuevo',
              onPressed: () => albumProvider.getAllTodos(),
              heightMultiplier: 0.35,
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }

  Widget _buildList(List<Album> albumInfo) => ListView.builder(
      controller: controller,
      itemCount: albumInfo.length,
      itemBuilder: (context, index) {
        return CardImage(
          album: albumInfo[index],
        );
      });
}
