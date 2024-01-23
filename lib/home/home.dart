import 'package:ds_student/bd/db_functions.dart';
import 'package:ds_student/widget/add_student.dart';
import 'package:ds_student/widget/list_widget.dart';
import 'package:ds_student/widget/serach.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatefulWidget{
  const ScreenHome ({super.key});

  @override
  State<ScreenHome> createState()=>  _ScreenHomeState();
     
}
class  _ScreenHomeState extends State<ScreenHome>{

@override

Widget build(BuildContext context){
  getallstudents();
  return Scaffold(
    appBar: AppBar(
      centerTitle:true,
       title:const Text('Student Details'),
    
      
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child:GestureDetector(
             onTap:(){
              showSearch(
              context: context,
              delegate: ScreenSearch(),
             );
            },
            child:const Icon(Icons.search,
          ),
        )
        )
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed:(){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>ScreenAdd()));

        
      } ,
      tooltip: 'Add Student',
      child: const Icon(Icons.add),

      ),
      body: const SafeArea(child: Padding(padding: EdgeInsets.all(10.0),
      child: ListDataWidget(),
      )),

  );

}


}