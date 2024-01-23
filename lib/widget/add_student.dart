

import 'dart:io';

import 'package:ds_student/bd/db_functions.dart';
import 'package:ds_student/home/home.dart';
import 'package:ds_student/modal/data_modal.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScreenAdd extends StatefulWidget{
  ScreenAdd ({super.key});

  @override
  State <ScreenAdd>createState()=>_ScreenAddState();

}
class _ScreenAddState extends State<ScreenAdd>{


  final TextEditingController _nameController =TextEditingController();

   
   final TextEditingController _ageController =TextEditingController();
    
    final TextEditingController _phoneController=TextEditingController();
   
    final TextEditingController _addressController =TextEditingController();
 
  final _formKey =GlobalKey<FormState>();
@override
 Widget build(BuildContext context){
  return Scaffold(
    resizeToAvoidBottomInset: false,
    appBar: AppBar(
      centerTitle:true,
      title:const Text('Add Student'),
      automaticallyImplyLeading:  false,
      actions: [
        Padding(padding: EdgeInsets.only(right:20),
        child: GestureDetector(onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx2)=> ScreenHome()));
        },
        child: const Icon(Icons.home_outlined),
        ),
        )
      ],

    ),
    body: SafeArea(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    _photo?.path==null?
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.green,
                      child: CircleAvatar(
                        radius: 57,
                        backgroundImage: AssetImage('lib/assest/ani.jpg'),
                      ),
                    )
                    :CircleAvatar(
                      radius: 60,
                      
                      child: CircleAvatar(
                        radius: 58,
                        backgroundImage: FileImage(
                        
                        File(_photo!.path,

                        ),
                        ),
                        ),
                    ),
                    Positioned(bottom: 0,
                    right: 0,
                    
                   child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 14, 14, 14),
                      ),
                      padding: const EdgeInsets.all(4),
                      child:Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,color: Colors.white),
                          child: IconButton(
                            
                          icon:  const Icon(Icons.camera_alt_outlined),
                          padding:EdgeInsets.zero,
                          onPressed: (){
                            getPhoto();
                          },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                 SizedBox(height:20),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Name',
                ),
                 validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' Name is Required';
                    } else {
                      return null;
                    }
                  },
              ),
              SizedBox(height: 20,),
              TextFormField(
                maxLength: 2,
                keyboardType: TextInputType.number,
                controller: _ageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter age',
                ),
                 validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' Age is Required';
                    } else {
                      return null;
                    }
                  },
              ),
               SizedBox(height: 20,),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Address',
                ),
                 validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address Required';
                    } else {
                      return null;
                    }
                  },
              ),
               SizedBox(height: 20,),
              TextFormField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: _phoneController,
                
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Phone Number',
                ),
                 validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }else if( value.length<10){
                      return ' Invalid phone number';
                    } else {
                      return null;
                    }
                  },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()&&_photo!=null){
                    addStudentToModel();
                  }else if(_photo== null){
                    ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(backgroundColor: Colors.red,
                    content: Text('Please add profile image!',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    )));
                  }else{
                    print('Empty field found');
                  }
                  },
                  child: const Text('Add Student')),
              ],
            ),
          ),
        ),
      ),
    ),
  );
 }

 popDialogueBox(){
  return showDialog(
    context: context, 
    builder: (context){
    return AlertDialog(
      title: const Text("Sucess"),
      titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
            actionsOverflowButtonSpacing: 20,
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (ctx) {
                      return const ScreenHome();
                    }));
                  },
                  child: const Text("Back")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Add New")),
            ],
            content: const Text("Saved successfully"),
          );
        });
 }


    
    
 
                  
                
             
  Future<void> addStudentToModel() async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _phone = _phoneController.text.trim();
    final _address = _addressController.text.trim();
    final _image = _photo;

    if (_photo!.path.isEmpty ||
        _name.isEmpty ||
        _phone.isEmpty||
        _age.isEmpty ||
        _address.isEmpty) {
      return;
    } else {
      //reset fields
      _nameController.text = '';
      _ageController.text = '';
      _phoneController.text = '';
      _addressController.text = '';
      _photo = null;
      setState(() {
        popDialogueBox(); //to show success message
      });
    }

    final studentObject = StudentModel(
        name: _name,
        age: _age,
        adress: _address,
        phone: _phone,
        photo: _image!.path,
        id: DateTime.now().millisecond.toString());
    print("$_name $_age $_address  $_phone");

    addStudent(studentObject);
  }

  File? _photo;
  Future<void> getPhoto() async {
    final photo = await ImagePicker ().pickImage(source: ImageSource.gallery);
    if (photo == null) {
    } else {
      final photoTemp = File(photo.path);
      setState(
        () {
          _photo = photoTemp;
        },
      );
    }
  }
}

  
 


