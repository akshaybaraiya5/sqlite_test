import 'package:flutter/material.dart';
import 'package:sqlite_test/screens/task_screen.dart';
import 'package:sqlite_test/services/sqlite_service.dart';
 
 class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});
 
   @override
   State<HomeScreen> createState() => _HomeScreenState();
 }
 
 class _HomeScreenState extends State<HomeScreen> {
   Future<List<Map<String, Object?>>>? data ;



   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      data = DatabaseHelper.getTask();
    });
  }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Todo App'),
         actions: [
           IconButton(onPressed: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>AddTaskScreen()));
           }, icon: Icon(Icons.add))
         ],
       ),
       body: FutureBuilder(future: data, builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

         if(!snapshot.hasData){
           return Center(
             child: Text('No data Found'),
           );

         } else{
           return ListView.builder(
               itemCount: snapshot.data.length,
               itemBuilder: (ctx,index){
                 return SizedBox(
                   height: 150,
                   child: Card(
                     child: Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('Task Name :- ${snapshot.data[index]['taskName']}'),
                           Text('Date :- ${snapshot.data[index]['date']}'),
                           Text('Time :- ${snapshot.data[index]['time']}'),
                           Text('Decription :- ${snapshot.data[index]['description']}',),
                         ],
                       ),
                     ),
                   ),
                 );

               });
         }

       },)
       

     );
   }
 }
 
 
