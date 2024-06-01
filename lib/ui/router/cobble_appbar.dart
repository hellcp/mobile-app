import 'package:flutter/material.dart';
import 'package:cobble/ui/router/scroll_controller.dart';

class CobbleAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Key key;
  final Widget? title;
  final Widget? leading;
  final List<Widget> actions;
  final PreferredSizeWidget? bottom;
  final double height;

  CobbleAppBar({
    this.key = const Key('default_key'),
    this.title,
    this.leading,
    this.actions = const [],
    this.bottom,
    this.height = 25.0 + 16.0 * 2,
  }) : super(key: key);

  @override
  _CobbleAppBarState createState() => _CobbleAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CobbleAppBarState extends State<CobbleAppBar> {
  bool _shouldElevate = false;

  @override
  void initState() {
    super.initState();
    if (!myScrollController.hasListeners) {
      myScrollController.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    myScrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final bool shouldElevate = myScrollController.hasClients &&
        myScrollController.offset > (widget.height / 2);
    if (shouldElevate != _shouldElevate) {
      setState(() {
        _shouldElevate = shouldElevate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.title == null
          ? PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: AppBar(
                elevation: _shouldElevate ? 4.0 : 0.0,
              ),
            )
          : PreferredSize(
              preferredSize: Size.fromHeight(widget.height),
              child: AppBar(
                leading: widget.leading,
                title: widget.title,
                actions: widget.actions,
                bottom: widget.bottom,
                elevation: _shouldElevate ? 4.0 : 0.0,
              ),
            );
  }
}

