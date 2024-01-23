import 'dart:io';

import 'package:ds_student/bd/db_functions.dart';
import 'package:ds_student/modal/data_modal.dart';
import 'package:ds_student/widget/profile.dart';
import 'package:flutter/material.dart';


class ListDataWidget extends StatefulWidget {
  const ListDataWidget({super.key});

  @override
  State<ListDataWidget> createState() => _ListDataWidgetState();
}

class _ListDataWidgetState extends State<ListDataWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      //here studentListNotifier is the valuenotifier object
      valueListenable: studentListNotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return ListView.separated(
          itemBuilder: (ctx, indexVal) {
            //studentdata used to fetch each student's data from student list one by one
            final studentdata = studentList[indexVal];
            return InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (ctx1) {
                  return ScreenProfile(
                    name: studentdata.name,
                    phone: studentdata.phone,
                    age: studentdata.age,
                    address: studentdata.adress,
                    photo: studentdata.photo,
                    index: indexVal,
                  );
                }),
                );
              },
              child: ListTile(
                textColor: Colors.amber,
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: FileImage(File(studentdata.photo)),
                ),
                title: Text(
                  "${studentdata.name}",
                ),

                //delete button
                trailing: IconButton(
                  onPressed: () {
                    // ignore: unnecessary_null_comparison
                    if (indexVal != null) {
                      //to show confirmation popup for delete
                      popupDialogueBox(indexVal);
                      //deleteStudent(indexVal);
                      print('Deleted value from $indexVal');
                    } else
                      print('ID passed is null');
                  },
                  icon: const Icon(Icons.delete),
                  tooltip: 'Delete profile',
                  color: Colors.red,
                ),
              ),
              
             );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: studentList.length,
        );
      },
    );
  }

  popupDialogueBox(int indexValue) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Do you want to delete this entry?"),
            titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16),
            actionsOverflowButtonSpacing: 20,
            actions: [
              ElevatedButton(
                  onPressed: () {
                    deleteStudent(indexValue);
                    Navigator.of(context).pop();
                  },
                  child: const Text("YES")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "NO",
                  )),
            ],
          );
        });
  }
}
