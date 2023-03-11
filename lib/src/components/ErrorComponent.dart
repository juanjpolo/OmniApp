import 'package:flutter/material.dart';

class ErrorContainer extends StatelessWidget {
  final BuildContext context;
  final String img;
  final String title;
  final String message;
  final String buttonText;
  final Function onPressed;
  final double heightMultiplier;

  const ErrorContainer(
      {Key? key,
      required this.buttonText,
      required this.context,
      required this.heightMultiplier,
      required this.img,
      required this.message,
      required this.onPressed,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Image(
            image: AssetImage(img),
            fit: BoxFit.cover,
            height: size.height * heightMultiplier),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black, fontSize: 24),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 30),
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(buttonText),
            ),
            onPressed: () => onPressed,
          ),
        ),
      ],
    );
  }
}
