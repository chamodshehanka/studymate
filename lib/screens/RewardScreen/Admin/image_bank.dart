// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class ImagesScreen extends StatefulWidget {
//   @override
//   _ImagesScreenState createState() => _ImagesScreenState();
// }

// class _ImagesScreenState extends State<ImagesScreen> {
//   Widget imageGrid() {
//     return GridView.builder(
//       itemCount: 30,
//       gridDelegate:
//           SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//       itemBuilder: (context, index) {
//         return ImageGridItem(index + 1);
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Image  Bank",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.deepPurple,
//         elevation: 0.0,
//         iconTheme: IconThemeData(color: Color(0xFF18D191), size: 10.0),
//       ),
//       body: Container(
//         child: imageGrid(),
//       ),
//     );
//   }
// }

// class ImageGridItem extends StatefulWidget {
//   final int _index;
//   ImageGridItem(index);

//   @override
//   _ImageGridItemState createState() => _ImageGridItemState();
// }

// class _ImageGridItemState extends State<ImageGridItem> {
//   Uint8List imageFile;
//   StorageReference badgesReference =
//       FirebaseStorage.instance.ref().child("badges");

//   getImage() {
//     final int maxSize = 1 * 1024 * 1024;
//     badgesReference
//         .child("badge_${widget._index}.png")
//         .getData(maxSize)
//         .then((data) {
//       this.setState(() {
//         imageFile = data;
//       });
//     }).catchError((error) {});
//   }

//   Widget decideGridTileWidget() {
//     if (imageFile == null) {
//       return Center(child: Text("Loading"));
//     } else {
//       return Image.memory(imageFile, fit: BoxFit.cover);
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getImage();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GridTile(child: decideGridTileWidget());
//   }
// }
