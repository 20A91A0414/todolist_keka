import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/utils/methods.dart';
import 'package:todo_list/utils/task_status_enum.dart';

class TodoStorage {

  static const String _todos = 'todos';

  static late final SharedPreferences _instance;

  // initialization..
  static Future<SharedPreferences> initialize() async {
    _instance = await SharedPreferences.getInstance();
    return _instance;
  }

  // getters..
  static String getTodos() {
    return _instance.getString(_todos) ?? "";
  }

  // setters..
  static setTodos(String todos) {
    _instance.setString(_todos, todos);
  }

  // methods..
  static addTodo(TodoModel model) {
    List<TodoModel> list = toList(getTodos());
    list.add(model);
    _instance.setString(_todos, jsonEncode(list));
  }

  static remove(TodoModel model){
    List<TodoModel> list = toList(getTodos());
    for(int i=0; i<list.length; i++){
      if(list[i].refId == model.refId){
        list.removeAt(i);
        break;
      }
    }
    print(jsonEncode(list));
    _instance.setString(_todos, jsonEncode(list));
  }

  static List<TodoModel> toList(String todos) {
    List<TodoModel> list = [];
    try{
      var storedList = jsonDecode(getTodos());
      for (int i = 0; i < storedList.length; i++) {
        try{
          list.add(TodoModel(title: storedList[i]['title'],
              description: storedList[i]['description'],
              dueDate: storedList[i]['dueDate'],
              category: storedList[i]['category'],
              priority: Methods.toPriorityEnum(storedList[i]['priority']),
              taskStatus: Methods.toTaskEnum(storedList[i]['status']),
              refId: storedList[i]['refId']));
        }catch(e){
          print(e);
        }
      }
    }catch(e){
      return [];
    }
    list.sort((a, b) => a.dueDate.compareTo(b.dueDate));  // newly added
    return list;

  }

  static bool updateProgress(TodoModel model, TaskStatus status) {

    List<TodoModel> list = toList(getTodos());
    for(int i=0; i<list.length; i++){
      if(list[i].refId == model.refId){
        list[i].taskStatus = status;
        break;
      }
    }
    _instance.setString(_todos, jsonEncode(list));
    return true;

  }


}

