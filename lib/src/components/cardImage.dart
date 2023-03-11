import 'package:flutter/material.dart';

import '../models/album_class.dart';

class CardImage extends StatelessWidget {
  final Album album;
  const CardImage({Key? key, required this.album}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        shadowColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 20,
        child: Column(
          children: [
            FadeInImage(
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/Loading_icon.gif'),
              placeholderFit: BoxFit.fill,
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4,
              image: NetworkImage(album.thumbnailUrl),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(album.title),
            )
          ],
        ));
  }
}
