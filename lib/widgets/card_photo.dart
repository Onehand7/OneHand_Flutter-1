import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onehand_app/global.dart';
import 'package:onehand_app/widgets/image_avatar_widget.dart';
import 'package:onehand_app/widgets/asset_avatar_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class CardPhoto extends StatefulWidget {
  CardPhoto({Key? key}) : super(key: key);

  @override
  _CardPhoto createState() {
    return _CardPhoto();
  }
}

class _CardPhoto extends State<CardPhoto> {
  File? image;
  // @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        this.image != null
            ? ImageAvatarWidget(
                image: this.image as File,
                onClicked: (source) => _pickImage(source))
            : AssetAvatarWidget(
                image: 'assets/images/avatar_user.png',
                onClicked: (source) => _pickImage(source)),
        this.image == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ignore: deprecated_member_use
                  FlatButton(
                    child: Text("Cambiar foto de perfil"),
                    color: Colors.white10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    onPressed: () async {
                      _pickImage(await _showImageSource(context));
                    },
                  ),
                ],
              )
            : Padding(
                padding: EdgeInsets.all(2.0),
              ),
      ],
    );
  }

  _pickImage(imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      final tmpImage = await _saveImagePermanently(image!.path);
      print(image.path);
      setState(() {
        this.image = tmpImage;
        Global.avatarURL = image.path;
      });
    } on PlatformException catch (e) {
      print("Error al elegir imagen: $e");
    }
  }

  Future<File> _saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  Future<ImageSource?> _showImageSource(BuildContext context) {
    if (Platform.isIOS) {
      return showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: Text('Cámara'),
              onPressed: () => Navigator.of(context).pop(ImageSource.camera),
            ),
            CupertinoActionSheetAction(
              child: Text('Galería'),
              onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
            )
          ],
        ),
      );
    } else {
      return showModalBottomSheet(
        context: context,
        builder: (context) => Wrap(children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Cámara'),
            onTap: () => Navigator.of(context).pop(ImageSource.camera),
          ),
          ListTile(
            leading: Icon(Icons.photo_album),
            title: Text('Galería'),
            onTap: () => Navigator.of(context).pop(ImageSource.gallery),
          ),
        ]),
      );
    }
  }
}
