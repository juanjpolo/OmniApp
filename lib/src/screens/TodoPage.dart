import 'package:entrando_en_ambiente/src/providers/todo_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../components/bottom_navbar_scalfold.dart';
import '../models/Universidad.dart';

import 'UniversidadDetails.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPage();
}

class _TodoPage extends State<TodoPage> {
  var showGrid = true; // Set to false to show ListView

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TodoProvider>(context, listen: false).getAllTodos();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return scalfold(
      Consumer<TodoProvider>(builder: (context, value, child) {
        final universidades = value.universidad;
        return showGrid ? _buildGrid(universidades) : _buildList(universidades);
      }),
      AppBar(
        centerTitle: true,
        title: const Text("Tyba App"),
        actions: [
          IconButton(
            icon: Icon(showGrid == true ? Icons.grid_on : Icons.view_list),
            onPressed: () {
              if (showGrid) {
                showGrid = false;
              } else {
                showGrid = true;
              }
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  Widget _buildGrid(universidades) => GridView.extent(
      maxCrossAxisExtent: 150,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: _buildGridTileList(universidades));

  List<Widget> _buildGridTileList(List<Universidad> universidades) =>
      List.generate(
          universidades.length,
          (i) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UniversidadDetail(universidad: universidades[i]),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(universidades[i].name),
                ),
              ));

  Widget _buildList(universidades) => ListView.builder(
      itemCount: universidades.length,
      itemBuilder: (context, index) {
        final Universidad universidad = universidades[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    UniversidadDetail(universidad: universidad),
              ),
            );
          },
          child: Container(
              child: ListTile(
            title: Text(universidad.name),
          )),
        );
      });
}
