import 'package:flutter/material.dart';
import 'package:onehand_app/constants.dart';

class BottomNavigationItem extends StatelessWidget {
  const BottomNavigationItem({
    required this.icon,
    this.iconActive,
    required this.title,
    this.isActive = false,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final IconData? iconActive;
  final Function? onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function(),
      child: Material(
        color: Colors.white,
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.all(7),
          child: Column(
            children: <Widget>[
              isActive
                  ? iconActive != null
                      ? Icon(
                          iconActive,
                          color: isActive
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        )
                      : Icon(
                          icon,
                          color: isActive
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        )
                  : Icon(
                      icon,
                      color: isActive
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
              Spacer(),
              Text(title,
                  style: kGrabBlackBoldSmall.copyWith(
                    color:
                        isActive ? Theme.of(context).primaryColor : Colors.grey,
                  )),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
