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
            ),);

        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        showDialog(context: context, builder: (BuildContext context){
          String newTaskTitle = "";
          String newDescription = "";
          return  AlertDialog(
            title: const Text("Add a new Task"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(onChanged: (value){
                  newTaskTitle = value;
                },
                decoration: InputDecoration(hintText: "Enter a task name"),),

                TextField(onChanged: (value){
                  newDescription = value;
                },
                decoration: InputDecoration(hintText: "Description of the task"),),
              ],
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: const Text("Cancel")),
              TextButton(onPressed: (){
                if(newTaskTitle.isNotEmpty && newDescription.isNotEmpty){
                  setState(() {
                    tasks.add({
                      'title': newTaskTitle,
                      'description': newDescription,
                    });

                  });
                }
                Navigator.of(context).pop();
              }, child: const Text("Add"))
            ],

          );
        });
      },child: Icon(Icons.add, color: Colors.orangeAccent),),

    );
  }
}
