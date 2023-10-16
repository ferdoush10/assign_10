import 'package:flutter/material.dart';
import 'text_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TextItem> items = [];
  TextEditingController titleTEController = TextEditingController();
  TextEditingController descriptionTEController = TextEditingController();
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo App",
          style: TextStyle(color: Colors.blue),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        actions: const [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(
              Icons.search,
              color: Colors.blue,
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: titleTEController,
                  decoration: InputDecoration(
                    hintText: 'Add Title',
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal.shade200,
                        width: 3,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: descriptionTEController,
                  decoration: InputDecoration(
                    hintText: 'Add Description',
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.teal.shade200, width: 3),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                  onPressed: () {
                    _addItem();
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  trailing: const Icon(
                    Icons.arrow_forward,
                    size: 30,
                  ),
                  leading: const Icon(
                    Icons.circle,
                    color: Colors.deepOrange,
                    size: 55,
                  ),
                  title: Text(
                    items[index].title,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(items[index].description),
                  onTap: () {
                    _showOptionsDialog(index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addItem() {
    String title = titleTEController.text;
    String description = descriptionTEController.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      setState(() {
        items.add(TextItem(title: title, description: description));
        titleTEController.clear();
        descriptionTEController.clear();
      });
    }
  }

  void _showOptionsDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Alert'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _editItem(index);
              },
              child: const Text(
                'Edit',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteItem(index);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.teal)),
            ),
          ],
        );
      },
    );
  }

  void _editItem(int index) {
    titleTEController.text = items[index].title;
    descriptionTEController.text = items[index].description;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 10),
              TextField(
                controller: titleTEController,
                decoration: const InputDecoration(
                  hintText: 'Enter Title',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 3),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionTEController,
                decoration: const InputDecoration(
                  hintText: 'Enter Description',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 3),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                ),
                onPressed: () {
                  _updateItem(index);
                  Navigator.of(context).pop();
                },
                child: const Text('Edit Done'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateItem(int index) {
    String title = titleTEController.text;
    String description = descriptionTEController.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      setState(() {
        titleTEController.clear();
        descriptionTEController.clear();
        items[index] = TextItem(title: title, description: description);
      });
    }
  }

  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }
}
