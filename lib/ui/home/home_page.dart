import 'package:cobble/localization/localization.dart';
import 'package:cobble/ui/home/tabs/locker_tab.dart';
import 'package:cobble/ui/home/tabs/store_tab.dart';
import 'package:cobble/ui/home/tabs/test_tab.dart';
import 'package:cobble/ui/home/tabs/watches_tab.dart';
import 'package:cobble/ui/router/cobble_scaffold.dart';
import 'package:cobble/ui/router/cobble_screen.dart';
import 'package:cobble/ui/router/uri_navigator.dart';
import 'package:cobble/ui/screens/placeholder_screen.dart';
import 'package:cobble/ui/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../common/icons/fonts/rebble_icons.dart';

class _TabConfig {
  final CobbleScreen child;
  final String label;
  final IconData icon;
  final GlobalKey<NavigatorState> key;

  _TabConfig(this.child, this.label, this.icon)
      : key = GlobalKey<NavigatorState>();
}

class HomePage extends HookWidget implements CobbleScreen {
  final _config = [
    // Only visible when in debug mode
    ... kDebugMode ? [_TabConfig(
      TestTab(),
      tr.homePage.testing,
      RebbleIcons.send_to_watch_checked,
    )] : [],
    // // TODO: Health not yet implemented
    // _TabConfig(
    //   HealthTab(),
    //   tr.homePage.health,
    //   RebbleIcons.health_journal,
    // ),
    _TabConfig(LockerTab(), tr.homePage.locker, RebbleIcons.locker),
    _TabConfig(StoreTab(), tr.homePage.store, RebbleIcons.rebble_store),
    _TabConfig(MyWatchesTab(), tr.homePage.watches, RebbleIcons.devices),
    _TabConfig(Settings(), tr.homePage.settings, RebbleIcons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    useUriNavigator(context);

    final index = useState(0);

    return WillPopScope(
      onWillPop: () async {
        /// Ask currently active child Navigator to pop. If child Navigator has
        /// nothing to pop it will return `false`, allowing root navigator to
        /// pop itself, closing the app.
        final popped = (await _config[index.value].key.currentState?.maybePop())!;
        return popped == false;
      },
      child: CobbleScaffold.page(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (i) => index.value = i,
          selectedIndex: index.value,
          destinations: _config
              .map(
                (tab) => NavigationDestination(
              icon: Icon(tab.icon),
              selectedIcon: Icon(tab.icon, color: Theme.of(context).colorScheme.onSecondary),
              label: tab.label,
            ),
          )
              .toList(),
        ),
        child: IndexedStack(
          children: _config
              .map(
                (tab) => Navigator(
              key: tab.key,
              onGenerateInitialRoutes: (navigator, initialRoute) => [
                    CupertinoPageRoute(builder: (_) => tab.child),
                  ],
                ),
              )
              .toList(),
          index: index.value,
        ),
      ),
    );
  }
}
