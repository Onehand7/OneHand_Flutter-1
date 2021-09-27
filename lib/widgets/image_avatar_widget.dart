import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onehand_app/widgets/avatar_class.dart';

class ImageAvatarWidget extends StatelessWidget {
  final File image;
  final ValueChanged<ImageSource> onClicked;
  const ImageAvatarWidget(
      {Key? key, required this.image, required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final avatar =
        AvatarClass(fileImage: this.image, onClicked: this.onClicked);
    return Center(
        child: Stack(
      children: [
        avatar.buildFileImage(context),
        Positioned(bottom: 0, right: 4, child: avatar.buildEditIcon(color))
      ],
    ));
  }
}
