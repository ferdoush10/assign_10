import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Item> items = [
    Item('Item ', false),
    Item('Item ', false),
    Item('Item ', false),
    Item('Item ', false),
    Item('Item ', false),
    Item('Item ', false),
    Item('Item ', false),
    Item('Item ', false),
    Item('Item ', false),
    Item('Item ', false),
  ];

  int selectedCount = 0;

  void _updateSelectedCount() {
    int count = 0;
    for (var item in items) {
      if (item.isSelected) {
        count++;
      }
    }
    setState(() {
      selectedCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selection Screen"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                items[index].isSelected = !items[index].isSelected;
                _updateSelectedCount();
              });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: items[index].isSelected ? double.infinity : null,
              color: items[index].isSelected ? Colors.deepPurple : null,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    "${(items[index].name)} ${index + 1}",
                    style: TextStyle(
                      color:
                          items[index].isSelected ? Colors.white : Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Total Selected Items:'),
                content: Text('Number of selected items: $selectedCount'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}

class Item {
  String name;
  bool isSelected;

  Item(this.name, this.isSelected);
}
