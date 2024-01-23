import 'package:ds_student/home/home.dart';
import 'package:ds_student/modal/data_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StudentModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

@override
Widget build(BuildContext context){
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
       primarySwatch: Colors.cyan,
       
       ),
       home: ScreenHome(),
  );
}
}