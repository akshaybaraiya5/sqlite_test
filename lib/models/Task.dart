import 'dart:typed_data';

class Task {
  int? id;
  late final String taskName;
  late final String date;
  late final String time;
  late final String description;




  Task({
    // required this.id
    required this.taskName,
    required this.date,
    required this.time,
    required this.description,



  });


  Task.fromJson(Map<String, dynamic> result)
      : id = result["id"],
        taskName = result["taskName"],
        date= result["date"],
        time = result["time"],
        description = result["description"];


  Map<String, Object?>  toJson() {
    return { 'taskName':taskName, 'date':date, 'time': time ,'description': description};
  }
}