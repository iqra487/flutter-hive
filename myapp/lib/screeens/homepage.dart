import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _todoController = TextEditingController();
  Box? _todoBox;

  @override
  void initState() {
    super.initState();
    Hive.openBox("todo").then((_value) {
      setState(() {
        _todoBox = _value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your todos!",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 219, 109, 146),
      ),
      body: _homeScreenUI(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 219, 109, 146),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => _showDialogBox(context)),
    );
  }

  Widget _homeScreenUI() {
    if (_todoBox == null) {
      return CircularProgressIndicator();
    }
    return ValueListenableBuilder(
        valueListenable: _todoBox!.listenable(),
        builder: (context, box, widget) {
          final todoKeys = _todoBox!.keys.toList();
          return SizedBox(
            child: ListView.builder(
                itemCount: todoKeys.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(index.toString()),
                  );
                }),
          );
        });
  }

  Future<void> _showDialogBox(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 237, 85, 136),
            title: Text(
              "Add a Todo <3",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            content: TextField(
              cursorColor: Colors.white,
              controller: _todoController,
              decoration: InputDecoration(fillColor: Colors.white),
            ),
            actions: [
              TextButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white)),
                onPressed: () {},
                child: Text(
                  "Done",
                  style: TextStyle(color: Color.fromARGB(255, 237, 85, 136)),
                ),
              )
            ],
          );
        });
  }
}
