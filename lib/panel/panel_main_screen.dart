import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onehand_app/pages/history_screen.dart';
import 'package:onehand_app/pages/inbox_screen.dart';
import 'package:onehand_app/pages/offers_screen.dart';
import 'package:onehand_app/pages/profile_screen.dart';
import 'package:onehand_app/panel/panel_client_screen.dart';
import 'package:onehand_app/widgets/bottom_navigation_item.dart';

class PanelMainScreen extends StatefulWidget {
  static const String id = 'main_screen';

  @override
  _PanelMainScreenState createState() => _PanelMainScreenState();
}

class _PanelMainScreenState extends State<PanelMainScreen> {
  late ScrollController _hideButtonController;
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    PanelClientScreen(),
    OffersScreen(),
    HistoryScreen(),
    InboxScreen(),
    ProfileScreen(),
  ];

  bool _isVisible = true;
  @override
  void initState() {
    super.initState();
    _isVisible = true;
    _hideButtonController = new ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _isVisible = false;
          print("**** $_isVisible up");
        });
      }
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _isVisible = true;
          print("**** $_isVisible down");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 10),
        height:
            _isVisible ? MediaQuery.of(context).viewPadding.bottom + 70 : 0.0,
        child: BottomAppBar(
          color: Colors.white,
          elevation: 8,
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: BottomNavigationItem(
                    icon: FontAwesomeIcons.compass,
                    iconActive: FontAwesomeIcons.solidCompass,
                    title: "Inicio",
                    onTap: () {
                      _selectedIndex = 0;
                      setState(() {});
                    },
                    isActive: _selectedIndex == 0,
                  ),
                ),
                Expanded(
                  child: BottomNavigationItem(
                    icon: FontAwesomeIcons.handHoldingUsd,
                    title: "Ofertas",
                    onTap: () {
                      _selectedIndex = 1;
                      setState(() {});
                    },
                    isActive: _selectedIndex == 1,
                  ),
                ),
                Expanded(
                  child: BottomNavigationItem(
                    icon: FontAwesomeIcons.history,
                    title: "Historial",
                    onTap: () {
                      _selectedIndex = 2;
                      setState(() {});
                    },
                    isActive: _selectedIndex == 2,
                  ),
                ),
                Expanded(
                  child: BottomNavigationItem(
                    icon: FontAwesomeIcons.inbox,
                    title: "Mensajes",
                    onTap: () {
                      _selectedIndex = 3;
                      setState(() {});
                    },
                    isActive: _selectedIndex == 3,
                  ),
                ),
                BottomNavigationItem(
                  icon: FontAwesomeIcons.userCircle,
                  iconActive: FontAwesomeIcons.solidUserCircle,
                  title: "Cuenta",
                  onTap: () {
                    _selectedIndex = 4;
                    setState(() {});
                  },
                  isActive: _selectedIndex == 4,
                ),
              ],
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        controller: _hideButtonController,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _widgetOptions.elementAt(_selectedIndex);
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
