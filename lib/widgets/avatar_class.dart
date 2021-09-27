import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarClass {
  String? assetImage;
  String? urlImage;
  File? fileImage;
  double? size;
  final ValueChanged<ImageSource> onClicked;

  AvatarClass(
      {this.assetImage,
      this.fileImage,
      this.urlImage,
      this.size,
      required this.onClicked});

  Widget buildAssetImage(BuildContext context) {
    return ClipOval(
        child: Material(
            color: Colors.transparent,
            child: Ink.image(
                image: AssetImage(this.assetImage as String),
                fit: BoxFit.cover,
                width: this.size ?? 160,
                height: this.size ?? 160,
                child: InkWell(onTap: () async {
                  final source = await _showImageSource(context);
                  if (source == null) {
                    return;
                  }
                  onClicked(source);
                }))));
  }

  Widget buildFileImage(BuildContext context) {
    final imageSource = this.fileImage as File;
    final imagePath = imageSource.path;
    final image = imagePath.contains('https://')
        ? NetworkImage(imagePath)
        : FileImage(File(imagePath));

    return ClipOval(
        child: Material(
            color: Colors.transparent,
            child: Ink.image(
                image: image as ImageProvider,
                fit: BoxFit.cover,
                width: this.size ?? 160,
                height: this.size ?? 160,
                child: InkWell(onTap: () async {
                  final source = await _showImageSource(context);
                  if (source == null) {
                    return;
                  }
                  onClicked(source);
                }))));
  }

  Widget buildNetworkImage(BuildContext context) {
    var image = FadeInImage.assetNetwork(
        placeholder: 'assets/images/loading.gif',
        image: this.urlImage as String);
    return ClipOval(
        child: Material(
            color: Colors.transparent,
            child: Ink.image(
                image: image.image,
                fit: BoxFit.cover,
                width: this.size ?? 160,
                height: this.size ?? 160,
                child: InkWell(onTap: () async {
                  final source = await _showImageSource(context);
                  if (source == null) {
                    return;
                  }
                  onClicked(source);
                }))));
  }

  Widget buildEditIcon(Color color) => buildCircle(color);

  Widget buildCircle(Color color) {
    return CircleAvatar(
        backgroundColor: color,
        child: Icon(Icons.camera_alt_outlined, color: Colors.white));
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
