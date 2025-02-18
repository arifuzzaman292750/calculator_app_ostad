import 'package:batch_9_apps/features/todo_app/ui/widgets/activity_count.dart';
import 'package:batch_9_apps/features/todo_app/ui/widgets/my_text_button.dart';
import 'package:batch_9_apps/features/todo_app/ui/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

class TodoAppScreen extends StatefulWidget {
  const TodoAppScreen({super.key});

  @override
  State<TodoAppScreen> createState() => _TodoAppScreenState();
}

class _TodoAppScreenState extends State<TodoAppScreen> {
  final TextEditingController _taskTEController = TextEditingController();
  final List<Map<String, dynamic>> _tasksList = [];
  // bool _showActiveTask = true;
  
  int get _activeTaskCount => _tasksList.where((task) => !task['isCompleted']).length;
  int get _completedTaskCount => _tasksList.where((task) => task['isCompleted']).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'Todo App',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ActivityCount(title: 'Active', count: _activeTaskCount.toString()),
                ActivityCount(title: 'Completed', count: _completedTaskCount.toString()),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasksList.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(UniqueKey().toString()),
                  background: Container(
                    color: Colors.green,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(
                      Icons.check_box_outlined,
                      color: Colors.amber.shade50,
                      size: 32,
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.delete,
                      color: Colors.amber.shade50,
                      size: 32,
                    ),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      _toggleTaskStatus(index);
                    } else {
                      _deleteTask(index);
                    }
                  },
                  child: Card(
                    color: Colors.amber,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(
                        _tasksList[index]['task'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: _tasksList[index]['isCompleted']
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      leading: Checkbox(
                        checkColor: Colors.amber,
                        fillColor: WidgetStateProperty.all(Colors.amber.shade50),
                        side: BorderSide(color: Colors.amber.shade50),
                        value: _tasksList[index]['isCompleted'],
                        onChanged: (value) => _toggleTaskStatus(index),
                      ),
                      trailing: TextButton.icon(
                        onPressed: () => _showTaskDialog(index: index),
                        label: Text(
                          'Edit',
                          style: TextStyle(
                              color: Colors.amber.shade50, fontSize: 18),
                        ),
                        icon: Icon(
                          Icons.edit,
                          color: Colors.amber.shade50,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskDialog(),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        elevation: 0,
        child: Icon(Icons.add, size: 24),
      ),
    );
  }

  void _showTaskDialog({int? index}) {
    _taskTEController.text = index != null ? _tasksList[index]['task'] : '';
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.amber.shade100,
        title: Text(
          index != null ? 'Edit Task' : 'Add Task',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: MyTextField(
          controller: _taskTEController,
          labelText: 'Enter Task',
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MyTextButton(
                child: 'Cancel',
                onPressed: () => Navigator.pop(context),
              ),
              MyTextButton(
                child: 'Save',
                onPressed: () {
                  if(_taskTEController.text.trim().isNotEmpty) {
                    if(index == null) {
                      _addTask(_taskTEController.text);
                    } else {
                      _editTask(index, _taskTEController.text);
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _addTask(String task) {
    _tasksList.add({'task': task, 'isCompleted': false});
    _taskTEController.clear();
    Navigator.pop(context);
    setState(() {});
  }

  void _toggleTaskStatus(int index) {
    _tasksList[index]['isCompleted'] = !_tasksList[index]['isCompleted'];
    setState(() {});
  }

  void _deleteTask(int index) {
    _tasksList.removeAt(index);
    setState(() {});
  }

  void _editTask(int index, String updateTask) {
    _tasksList[index]['task'] = updateTask;
    Navigator.pop(context);
    setState(() {});
  }
}
