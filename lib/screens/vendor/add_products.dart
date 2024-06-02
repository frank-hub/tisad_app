import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tisad_shop_app/constants.dart';
import 'package:tisad_shop_app/theme.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool agreePersonalData = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController catController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  int? vendorId ;
  File? _imageFile;
  String imageName = '';
  String category = 'Electronics';

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
          imageName = File(pickedFile.name).toString();
        } else {
          print('No image selected.');
        }
      });
    }
  }


  Future<void> _addProduct() async {

    final String url = '$BaseUrl/product/store';
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.fields['vendor_id'] = vendorId.toString();
    request.fields['p_name'] = nameController.text;
    request.fields['description'] = descController.text;
    request.fields['stock'] = quantityController.text;
    request.fields['category_id'] = category;
    request.fields['price'] = priceController.text;
    // request.fields['image'] = '';

    final _imageFile = this._imageFile;
    if (_imageFile != null) {
      print("Image uploaded file found");
      try {
        var imageStream = http.ByteStream(_imageFile.openRead());
        var length = await _imageFile.length();
        var multipartFile = http.MultipartFile('image', imageStream, length,
            filename: _imageFile.path.split('/').last);
        try{
          request.files.add(multipartFile);
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
      if (response.statusCode == 200) {

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product Posted Successfully'),
            )
        );
      } else {

        var responseBody = await response.stream.bytesToString();

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.red,
                content: Text('Not Submitted '+ responseBody
                ))
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Text('Error $e'))
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    // Fetch user details from your API using the authentication token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('$BaseUrl/user');
    final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'}
    );

    if (response.statusCode == 200) {
      var userData = json.decode(response.body);
      setState(() {
        vendorId = userData['id'];
      });
    } else {
      vendorId = 1;
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(
                          Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 20,),
                    Text("Add Products"+vendorId.toString(),
                      style: TextStyle(
                          color: lightColorScheme.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25.0,
                ),
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Name';
                    }
                    return nameController.text = value;
                  },
                  decoration: InputDecoration(
                    label: const Text('Product Name'),
                    hintText: 'Enter Product Name',
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
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Quantity';
                    }
                    return quantityController.text = value;
                  },
                  decoration: InputDecoration(
                    label: const Text('Quantity'),
                    hintText: 'Enter Quantity',
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
                const SizedBox(height: 25,),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Price';
                    }
                    return priceController.text = value;
                  },
                  decoration: InputDecoration(
                    label: const Text('Price'),
                    hintText: 'Enter Price',
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
                  controller: descController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description';
                    }
                    return descController.text = value;
                  },
                  decoration: InputDecoration(
                    label: const Text('Description'),
                    hintText: 'Enter Description',
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
                Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: category,
                      onChanged: (newValue) {
                        setState(() {
                          category = newValue!;
                        });
                      },
                      items: [
                        'Electronics',
                        'Clothing & Fashion',
                       ' Home & Kitchen',
                        'Health & Beauty',
                        'Sports & Outdoors',
                        'Books & Stationery',
                        'Toys & Games',
                        'Automotive',
                        'Jewelry & Accessories',
                        'Pet Supplies',
                        'Food & Beverages',
                        'Arts & Crafts',
                        'Baby & Maternity',
                        'Electronics Accessories',
                        'Office Supplies',
                      ]
                          .map((serviceProvider) {
                        return DropdownMenuItem<String>(
                          value: serviceProvider,
                          child: Text(serviceProvider,
                            style: TextStyle(
                                color: Color(0xff545454),
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        );
                      }).toList(),
                      hint: Text('Hike Difficulty'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Text("Images",
                  style: TextStyle(
                      color: lightColorScheme.primary,
                      fontSize: 17,
                      fontWeight: FontWeight.w500
                  ),
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
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Upload File : $imageName',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.upload),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // if (_filePath.isNotEmpty && File(_filePath).existsSync())
                    //   Image.file(
                    //     File(_filePath),
                    //     width: 200,
                    //     height: 200,
                    //     fit: BoxFit.cover,
                    //   ),
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
                  onTap: () {
                    _addProduct();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: lightColorScheme.primary
                    ),
                    child: const Center(
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