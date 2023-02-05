import 'package:entrando_en_ambiente/src/models/Universidad.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/todo_provider.dart';

class UniversidadDetail extends StatefulWidget {
  const UniversidadDetail({Key? key, required this.universidad})
      : super(key: key);
  final Universidad universidad;

  @override
  State<UniversidadDetail> createState() => _UniversidadDetailState();
}

class _UniversidadDetailState extends State<UniversidadDetail> {
  final TextEditingController cardNumberController = TextEditingController();
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);
      Navigator.pop(context, 'OK');
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);
      Navigator.pop(context, 'OK');

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(widget.universidad.name)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width / 1.12,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: cardNumberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    hintText: 'Número de estudiantes',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.numbers_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                  ],
                  onChanged: (value) {
                    Provider.of<TodoProvider>(context, listen: false)
                        .incrementX(int.parse(value.isEmpty ? '0' : value));
                  },
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                title: Text(widget.universidad.name),
              ),
              ListTile(
                title: Text(widget.universidad.alpha_two_code),
              ),
              ListTile(
                title: Text(widget.universidad.web_pages[0]),
              ),
              ListTile(
                title: Text(widget.universidad.country),
              ),
              Consumer<TodoProvider>(builder: (context, value, child) {
                return ListTile(
                  title: Text('Numero de estudiantes: ' +
                      value.numeroEstudiantes.toString()),
                );
              }),
              image != null
                  ? Container(
                      child: Image.file(
                        image!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Subir Imagen desde...'),
            actions: <Widget>[
              TextButton(
                onPressed: () => {pickImageC()},
                child: const Text('Camara'),
              ),
              TextButton(
                onPressed: () => {pickImage()},
                child: const Text('Galeria'),
              ),
            ],
          ),
        ),
        child: const Icon(Icons.camera),
      ),
    );
  }
}
