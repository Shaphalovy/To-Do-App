import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ToDoListScreen(),
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

List<Map<String, String>> tasks = [];

class _ToDoListScreenState extends State<ToDoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.all(15),
            shadowColor: Colors.orangeAccent,
            child: ListTile(
              title: Text(tasks[index]['title']!),
              subtitle: Text(tasks[index]['description']!),
              trailing: IconButton(onPressed: (){
                setState(() {
                  tasks.removeAt(index);
                });
              }, icon: Icon(Icons.delete), color: Colors.red,),
              onTap: () {
                _editTaskDialog(index);
              },

            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String newTaskTitle = "";
              String newDescription = "";
              return AlertDialog(
                title: const Text("Add a new Task"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (value) {
                        newTaskTitle = value;
                      },
                      decoration: InputDecoration(hintText: "Enter a task name"),
                    ),
                    TextField(
                      onChanged: (value) {
                        newDescription = value;
                      },
                      decoration:
                      InputDecoration(hintText: "Description of the task"),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      if (newTaskTitle.isNotEmpty &&
                          newDescription.isNotEmpty) {
                        setState(() {
                          tasks.add({
                            'title': newTaskTitle,
                            'description': newDescription,
                          });
                        });
                      }
                      Navigator.of(context).pop();
                    },
                    child: const Text("Add"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add, color: Colors.orangeAccent),
      ),
    );
  }

  void _editTaskDialog(int index) {
    // Initialize TextEditingControllers
    TextEditingController titleController =
    TextEditingController(text: tasks[index]['title']);
    TextEditingController descriptionController =
    TextEditingController(text: tasks[index]['description']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit your task!"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: "Task title"),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(hintText: "Task description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                String updatedTitle = titleController.text;
                String updatedDescription = descriptionController.text;

                if (updatedTitle.isNotEmpty &&
                    updatedDescription.isNotEmpty) {
                  setState(() {
                    tasks[index] = {
                      'title': updatedTitle,
                      'description': updatedDescription,
                    };
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
