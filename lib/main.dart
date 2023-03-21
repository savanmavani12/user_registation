import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int Steper = 0;

  String? selectedImagePath;
  final ImagePicker _picker = ImagePicker();

  List gender = ["Male", "Female", "Other"];
  String? select;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                end: Alignment.centerRight,
                begin: Alignment.centerLeft,
                colors: <Color>[
                  Colors.orangeAccent,
                  Colors.white,
                  Colors.green,
                ]),
          ),
        ),
        title: const Text(
          "Edit Your Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stepper(
        physics: const BouncingScrollPhysics(),
        currentStep: Steper,
        onStepTapped: (val) {
          setState(() {
            Steper = val;
          });
        },
        onStepContinue: () {
          setState(() {
            if (Steper < 10) Steper++;
          });
        },
        onStepCancel: () {
          setState(() {
            if (Steper > 0) Steper--;
          });
        },
        steps: [
          Step(
            title: const Text("Profile Picture"),
            content: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: (selectedImagePath != null)
                      ? FileImage(File(selectedImagePath!))
                      : null,
                  backgroundColor: Colors.grey.withOpacity(0.5),
                  child: (selectedImagePath != null)
                      ? const Text("")
                      : const Text(
                          "ADD",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                          ),
                        ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            scrollable: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            title: const Text(
                              "When You go to pick Image ?",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  XFile? pickerFile = await _picker.pickImage(
                                      source: ImageSource.gallery);

                                  if (pickerFile != null) {
                                    setState(() {
                                      selectedImagePath = pickerFile.path;
                                    });
                                  }
                                },
                                child: const Text("gallery"),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  XFile? pickerFile = await _picker.pickImage(
                                      source: ImageSource.camera);
                                  setState(() {
                                    selectedImagePath = pickerFile!.path;
                                  });
                                },
                                child: const Text("Camera"),
                              ),
                            ],
                          );
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Step(
            title: const Text("Name"),
            content: TextField(
              decoration: decoration(Icons.person_outline, "Enter Your Name"),
            ),
          ),
          Step(
            title: const Text("Phone"),
            content: TextField(
              keyboardType: TextInputType.phone,
              decoration: decoration(Icons.call, "Enter Your Number"),
            ),
          ),
          Step(
            title: const Text("Email"),
            content: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: decoration(Icons.email_outlined, "Enter Your Email"),
            ),
          ),
          Step(
            title: const Text("DOB"),
            content: TextField(
              keyboardType: TextInputType.number,
              decoration: decoration(Icons.date_range, "Enter Your Birth Date"),
            ),
          ),
          Step(
            title: const Text("Gender"),
            content: Row(
              children: <Widget>[
                addRadioButton(0, 'Male'),
                addRadioButton(1, 'Female'),
                addRadioButton(2, 'Others'),
              ],
            ),
          ),
          Step(
            title: const Text("Current Location"),
            content: TextField(
              decoration: decoration(Icons.home, "Enter Your Address"),
            ),
          ),
          Step(
            title: const Text("Nationality"),
            content: TextField(
              decoration: decoration(Icons.flag, "Enter Your Nationality"),
            ),
          ),
          Step(
            title: const Text("Religion"),
            content: TextField(
              decoration:
                  decoration(Icons.adjust_rounded, "Enter Your Religion"),
            ),
          ),
          Step(
            title: const Text("Languages"),
            content: TextField(
              decoration: decoration(Icons.language_rounded, "Enter Languages"),
            ),
          ),
          Step(
            title: const Text("Biography"),
            content: TextField(
              decoration: decoration(Icons.details, "Enter Biography"),
            ),
          ),
        ],
      ),
    );
  }

  decoration(icon, String hint) {
    return InputDecoration(
      icon: Icon(icon),
      hintText: hint,
    );
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio<String>(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              select = value.toString();
            });
          },
        ),
        Text(title)
      ],
    );
  }
}
