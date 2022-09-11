import 'dart:convert';
import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static final String ROUTE_NAME = 'Upload image';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String result = '';
  File? cameraImage;
  File? frontImage;
  File? backImage;
  String outputText = "";
  String idNum = "";
  var controllerId = TextEditingController();

  @override
  void initUser() {
    controllerId = TextEditingController();
  }

  Future pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      frontImage = File(pickedFile!.path);
    });
  }

  Future pickBackImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      backImage = File(pickedFile!.path);
      performImageLabeling();
    });
  }

  pickImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      cameraImage = File(pickedFile!.path);
      performImageLabeling();
    });
  }

  processImageFromCamera(inputImage) async {
    setState(() {
      outputText = "";
    });
  }

  performImageLabeling() async {
    final FirebaseVisionImage firebaseVisionImage =
        FirebaseVisionImage.fromFile(backImage);
    final TextRecognizer recognizer = FirebaseVision.instance.textRecognizer();

    VisionText visionText = await recognizer.processImage(firebaseVisionImage);
    result = '';
    setState(() {
      for (TextBlock block in visionText.blocks) {
        final String txt = block.text;
        for (TextLine line in block.lines) {
          for (TextElement element in line.elements) {
            result += element.text + " ";
          }
        }
        result += "\n\n";
      }
      List<String> ids = result.split('\n');
      idNum = (ids[4].substring(0, 15));
      controllerId.text = idNum;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Upload Id',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      pickImageFromGallery();
                      // uploadImage('image', fontImage);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF242366),
                          borderRadius: BorderRadius.circular(10)),
                      width: 170,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: Text("Upload the front of the ID",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300),),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 25),
                  child: frontImage != null
                      ? Image.file(
                          frontImage!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        )
                      : Container(
                          width: 100,
                          height: 100,
                          child: const Icon(
                            Icons.photo,
                            size: 100,
                            color: Colors.grey,
                          ),
                        ))
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      pickBackImageFromGallery();
                      // uploadImage('image', backImage);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF242366),
                          borderRadius: BorderRadius.circular(10)),
                      width: 170,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text("Upload the back of the ID",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300),),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 25),
                  child: backImage != null
                      ? Image.file(
                          backImage!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        )
                      : Container(
                          width: 100,
                          height: 100,
                          child: const Icon(
                            Icons.photo,
                            size: 100,
                            color: Colors.grey,
                          ),
                        ))
            ],
          ),
          Container(
            child: Column(
              children: [
                const SizedBox(
                  width: 100,
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: controllerId,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          labelText: 'Id',
                          labelStyle: TextStyle(color: Colors.grey)),
                      maxLength: 15,
                      onChanged: (value)=>idNum=value,

                    ))
              ],
            ),
          ),
            SizedBox(height: 65),
            Padding(
            padding: const EdgeInsets.all(8),
    child: Container(
    width: double.infinity,
    height: 40,
    decoration: BoxDecoration(
    color: const Color(0xFF242366),
    borderRadius: BorderRadius.circular(10),
    ),

            child: TextButton(
                onPressed: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Uploading"),
                      duration: Duration(seconds: 3),
                    ),

                  );
                  final frontLink = await uploadImage("Front Image", frontImage);
                  final backLink = await uploadImage("Back Image", backImage);
                  print(frontLink);
                  print(backLink);
                  Navigator.pop(context, [idNum, frontLink, backLink]);
                },
                child: Center(
                  child: Text("Done",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
                )),
          ))
        ],
      ),
    );
  }

  Future<String?> uploadImage(String title, File? file) async {
    final request = http.MultipartRequest(
        "POST", Uri.parse("https://api.imgur.com/3/upload"));
    request.fields['title'] = "dummyImage";
    request.headers['Authorization'] = "Client-ID " + "9ee90cd9c08d197";

    var picture = http.MultipartFile(
        'image', file!.readAsBytes().asStream(), file.lengthSync(),
        filename: 'testimage.jpg');

    request.files.add(picture);

    var response = await request.send();

    var responseData = await response.stream.toBytes();

    var result = String.fromCharCodes(responseData);

    Map<String, dynamic>? map = json.decode(result);

    if (map != null) {
      return map['data']['link'];
    }
    return null;
  }
}
