
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tisad_shop_app/constants.dart';
import 'package:tisad_shop_app/screens/vendor/thank_you.dart';
import 'package:tisad_shop_app/theme.dart';
import 'package:http/http.dart' as http;

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  bool agreePersonalData = true;
  TextEditingController typeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController b_nameController = TextEditingController();
  TextEditingController townController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController relevantDocsController = TextEditingController();

  String type = '';
  String name = '';
  String b_name = '';
  String email = '';
  String town = '';
  String city = '';
  String relevant_docs = '';
  String files = '';
  File? _imageFile;



  Future<void> _getImage() async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      print('Storage permission granted');
      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } else {
      print('Storage permission denied-'+status.toString());
      final newStatus = await Permission.storage.request();
      print('I have been given access !!!');
      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path as String);
        } else {
          print('No image selected.');
        }
      });
    }
  }

Future<void> CreateVendor() async{
  final url = Uri.parse('$BaseUrl/vendor/store');

  var request = http.MultipartRequest('POST',url);

  request.fields['type'] =type;
  request.fields['name'] = name;
  request.fields['b_name'] = b_name;
  request.fields['email'] = email;
  request.fields['town'] = town;
  request.fields['city'] = city;
  request.fields['relevant_docs'] = relevant_docs;
  // request.fields['files'] = files;

  // Add image file to the request
  final _imageFile = this._imageFile;
  if (_imageFile != null) {
    print("Image uploaded file found");
    try {
      var imageStream = http.ByteStream(_imageFile.openRead());
      var length = await _imageFile.length();
      var multipartFile = http.MultipartFile('files', imageStream, length,
          filename: _imageFile.path.split('/').last);
      try{
        request.files.add(multipartFile);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Image Uploaded') ));

      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Oops Image Not Uploaded') ));
      }
      print(multipartFile.filename);
    } catch (e) {
      print("Error uploading image: $e");
      // Handle image upload error (e.g., show a snackbar to the user)
    }
  }

  try {
    var response = await request.send();

    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vendor Created Successfully'),
          backgroundColor: Colors.green,
        )
      );
      nameController.clear();
      b_nameController.clear();
      emailController.clear();
      townController.clear();
      cityController.clear();

      Navigator.push(context, MaterialPageRoute(builder:
      (context)=> ThankYou()
      ));
    }else{
      print(name);
      print(email);
      print(type);
      print(b_name);
      print(town);
      print(city);
      print(relevant_docs);
      print(files);
      // Request failed
      var responseBody = await response.stream.bytesToString();
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text('Oops Failed to save Vendor'+responseBody),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch(e){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error $e'),
        backgroundColor: Colors.red,
      )
    );
  }

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Vendor On Boarding Details",
                        style: TextStyle(
                          color: lightColorScheme.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text("Enter your vendor details in below field",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: 'Business',
                      groupValue: type,
                      onChanged: (value) {
                        setState(() {
                          type = value!;
                        });
                      },
                    ),
                    Text("Business"),
                    Radio(
                      value: 'Individual',
                      groupValue: type,
                      onChanged: (value) {
                        setState(() {
                          type = value!;
                        });
                      },
                    ),
                    Text("Individual"),
                  ],
                ),
                const SizedBox(
                  height: 25.0,
                ),
                TextFormField(
                 controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name';
                    }
                    name = value;
                  },
                  onChanged: (value){
                   setState(() {
                     name = value;
                   });
                  },
                  decoration: InputDecoration(
                    label: const Text('Name'),
                    hintText: 'Enter Name',
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: lightColorScheme.primary, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                TextFormField(
                  controller: b_nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Business Name';
                    }
                    return null;
                  },
                  onChanged: (value){
                    setState(() {
                      b_name = value;
                    });
                  },
                  decoration: InputDecoration(
                    label: const Text('Business Name'),
                    hintText: 'Enter Business Name',
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: lightColorScheme.primary, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                TextFormField(
                  controller: emailController,
                  onChanged: (value){
                    setState(() {
                      email = value;
                    });
                  },
                  decoration: InputDecoration(
                    label: const Text('Email'),
                    hintText: 'Enter Email',
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: lightColorScheme.primary, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                TextField(
                  controller: townController,
                  onChanged: (value){
                    setState(() {
                      town = value;
                    });
                  },
                  decoration: InputDecoration(
                    label: const Text('Town'),
                    hintText: 'Enter Town',
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: lightColorScheme.primary, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                TextField(
                  controller: cityController,
                  onChanged: (value){
                    setState(() {
                      city = value;
                    });
                  },
                  decoration: InputDecoration(
                    label: const Text('City'),
                    hintText: 'Enter City',
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: lightColorScheme.primary, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Text("Do you have relevant valid certificates & licenses",
                  style: TextStyle(
                      color: lightColorScheme.primary,
                      fontSize: 17,
                      fontWeight: FontWeight.w500
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: 'Yes',
                      groupValue: relevant_docs,
                      onChanged: (value) {
                        setState(() {
                          relevant_docs = value!;
                        });
                      },
                    ),
                    Text("Yes"),
                    Radio(
                      value: 'I will Upload',
                      groupValue: relevant_docs,
                      onChanged: (value) {
                        setState(() {
                          relevant_docs = value!;
                        });
                      },
                    ),
                    Text("I will Upload later"),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: _getImage,
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                               'Upload File',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.upload),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    _imageFile == null
                        ? Placeholder() // Placeholder for image if no image is selected
                        : Image.file(
                      _imageFile!,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: agreePersonalData,
                      onChanged: (bool? value) {
                        setState(() {
                          agreePersonalData = value!;
                        });
                      },
                      activeColor: lightColorScheme.primary,
                    ),
                    const Text(
                      'I agree to the processing of ',
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                    Text(
                      'Personal data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: lightColorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25.0,
                ),
                // signup button

                InkWell(
                  onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context)
                    // => ThankYou()
                    // ));
                    CreateVendor();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: lightColorScheme.primary
                    ),
                    child: Center(
                      child: Text('Submit',
                      style: TextStyle(
                        color: Colors.white
                      ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
              ]
          ),
        ),
      ),
    );
  }
}
