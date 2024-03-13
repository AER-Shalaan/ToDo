class Task{
  String? id;
  String? title;
  String? description;
  int? date;
  int? time;
  bool? isDone;
  Task({this.id,required this.title, required this.date,required this.time,required this.description,this.isDone=false});

  Task.fromFirestore(Map<String , dynamic> data){
    id = data["id"];
    title = data["title"];
    description = data["description"];
    date = data["date"];
    time = data["time"];
    isDone = data["isDone"];
  }

  Map<String,dynamic> toFirestore(){
    Map<String, dynamic> data={
      "id" : id,
      "title" : title,
      "description" : description,
      "date" : date,
      "time" : time,
      "isDone" : isDone
    };
    return data;
}
}