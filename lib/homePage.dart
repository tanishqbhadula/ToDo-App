import 'package:flutter/material.dart';
import 'package:todo_app/colors.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/todoitem.dart';
//import 'package:todo_app/todolist.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  final todoList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final TextEditingController controller = TextEditingController();

  void initState() {
    _foundToDo = todoList;
    super.initState();
  }

  void _todoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id); 
    });
  }
  
  void _addTask() {
    if (controller.text.trim().isEmpty) return;
    setState(() {
      todoList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: controller.text.trim(),
      ));
      controller.clear();
    });
  }

  void _filter(String keyword) {
    List<ToDo> results = [];
    if(keyword.trim().isEmpty) {
      results = todoList;
    }
    else {
      results = todoList.where((item) => item.todoText!.toLowerCase().contains(keyword.toLowerCase())).toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgWhite,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu, color: tdBlack, size: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                //child: Image.asset('asset\tanishq pfp.jpg')
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(height: 15,),
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          'Tasks',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      for (ToDo todo in _foundToDo.reversed) 
                      ToDoItem(
                        todo: todo,
                        onToDoChanged: _todoChange,
                        onDeleteItem: _deleteToDoItem,
                      ),
                      SizedBox(height: 60,)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    margin: EdgeInsets.only(bottom: 20, right: 15, left: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [BoxShadow(
                        color: Color.fromARGB(255, 192, 192, 192),
                        offset: Offset(0.0, 0.0),
                        blurRadius: 5.0,
                        spreadRadius: 0.0,
                      ),],
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Enter task',
                        border: InputBorder.none,
                      )
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right:20,),
                  child: ElevatedButton(
                    onPressed: () => _addTask(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      foregroundColor: Colors.white,
                      minimumSize: Size(50, 50),
                      elevation: 2,
                    ),
                    child: Icon(Icons.add)
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _filter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: tdBlack, size: 20),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey,),
        ),
      ),
    );
  }
}
