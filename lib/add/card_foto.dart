import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onehand_spa/add/ImagePickerHandler.dart';

class CardFotos extends StatefulWidget {
  @override
  CardFoto createState() {
    return CardFoto();
  }
}

class CardFoto extends State<CardFotos> {
  //static File croppedFile;
  ///ImagePickerHandler imagePicker;
  // @override
  // void initState() {

  //   super.initState();
  //   ///imagePicker = ImagePickerHandler(this);
  // }

  // @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: InkWell(
            child: Container(
              height: 200,
              width: 600,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: deprecated_member_use
            FlatButton(
              child: Text("Galeria"),
              color: Colors.white10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              onPressed: () {
                //imagePicker.pickImageFroomGallery(ImageSource.gallery);
              },
            ),
            SizedBox(
              width: 10,
            ),
            // ignore: deprecated_member_use
            FlatButton(
              child: Text("Camara"),
              color: Colors.white10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              onPressed: () {},
            )
          ],
        ),
      ],
    );
  }

  @override
  userImage(File _image) {
    // TODO: implement userImage
    throw UnimplementedError();
  }
}
