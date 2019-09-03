import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateMedicalRecordScreen extends StatefulWidget {
  _CreateMedicalRecordScreenState createState() =>
      _CreateMedicalRecordScreenState();
}

class _CreateMedicalRecordScreenState extends State<CreateMedicalRecordScreen> {
  File image;
  bool _isUploaded;
  String _downloadUrl;

  final StorageReference reference =
      FirebaseStorage.instance.ref().child('medicalRecords/image1.jpg');

  Future<dynamic> getImage(bool isCamera) async {
    var pickImage;
    isCamera
        ? pickImage = await ImagePicker.pickImage(source: ImageSource.camera)
        : await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = pickImage;
    });
  }

  Future<dynamic> uploadImage() async {
    final StorageUploadTask task = reference.putFile(image);
    /* StorageTaskSnapshot snapshot = */ await task.onComplete;
    //

    setState(() {
      _isUploaded = true;
    });
  }

  Future downloadImage() async {
    String downloadAddress = await reference.getDownloadURL();
    setState(() {
      _downloadUrl = downloadAddress;
    });
  }

  Widget enableUpload() {
    return Container(
        child: Column(children: <Widget>[
      Image.file(
        image,
        height: 300.0,
        width: 300.0,
      ),
      RaisedButton(
        color: Colors.deepPurpleAccent,
        child: Text('Upload'),
        textColor: Colors.white,
        onPressed: () {
          uploadImage();

          if (_isUploaded) {
            // Navigator.pop(context);
            downloadImage();
          }
        },
      )
    ]));
  }

  @override
  Widget build(BuildContext context) {
    var createMedicalRecordBody = Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: image == null ? Text('Select an image') : enableUpload(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: image != null
                ? Image.network(_downloadUrl)
                : Image.network(
                    'https://hacktoberfest.digitalocean.com/pretty_logo.png'),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Colors.deepPurpleAccent,
                textColor: Colors.white,
                child: Text('Add Image'),
                onPressed: () => {getImage(false)},
              )),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Colors.deepPurpleAccent,
                textColor: Colors.white,
                child: Text('Take a photo'),
                onPressed: () => {getImage(true)},
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              color: Colors.redAccent,
              textColor: Colors.white,
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Create Medical Record'),
              backgroundColor: Colors.deepPurple,
            ),
            body: createMedicalRecordBody));
  }
}
