import 'package:todo_list/utils/priority_enum.dart';
import 'package:todo_list/utils/task_status_enum.dart';

class Methods {


  static Priority toPriorityEnum(String name) {

    if(name == Priority.medium.name){
      return Priority.medium;
    }
    if(name == Priority.high.name){
      return Priority.high;
    }
    return Priority.low;
  }

  static TaskStatus toTaskEnum(String name) {

    if(name == TaskStatus.newTask.name){
      return TaskStatus.newTask;
    }
    if(name == TaskStatus.completed.name){
      return TaskStatus.completed;
    }
    return TaskStatus.progress;
  }

  static int getDays(String dueDate){
    try{
      int days = DateTime.parse(dueDate).difference(DateTime.now()).inDays;
      return ++days;
    }catch(e){
      return 0;
    }
  }


}
