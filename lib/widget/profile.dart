import 'dart:io';

import 'package:ds_student/bd/db_functions.dart';
import 'package:ds_student/home/home.dart';
import 'package:ds_student/widget/update.dart';
import 'package:flutter/material.dart';


class ScreenProfile extends StatefulWidget {
  final String name;
  
  final String age;
  final String address;
  final String photo;
  final String   phone;
  final int index;

  const ScreenProfile(
      {super.key,
      required this.name,
   required this.phone,
      required this.age,
       required this .address,
      required this.photo,
      required this.index});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  @override
  Widget build(BuildContext context) {
    getallstudents();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,

           title:const Text('Student Profile'),
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx2) => const ScreenHome()));
                },
                child: const Icon(Icons.close_rounded),
              ),
            )
          ],
        ),
        body: SafeArea(
            child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    
                    'Details of ${widget.name} ',
                    
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color.fromARGB(255, 10, 10, 10),
                    child: CircleAvatar(
                      radius: 48,
                      backgroundImage: FileImage(
                        File(
                          widget.photo,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        ' Name:\t',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        widget.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Age: \t',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        widget.age,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Phone Number:\t',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        widget.phone,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Address:\t',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        widget.address,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton.icon(
                      onPressed: (() {
                        //setState(() {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: ((context) {
                          return ScreenUpdate(
                              name: widget.name,
                              phone: widget.phone,
                              age: widget.age,
                              address: widget.address,
                              photo: widget.photo,
                              index: widget.index);
                        })));
                        //});
                      }),
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit'))
                ],
              ),
            ),
          ),
        )));
  }
}
