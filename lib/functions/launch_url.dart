import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

Future launchURL(BuildContext context, String url) async {
  try {
    await launch(
      url,
      option: CustomTabsOption(
        toolbarColor: Theme.of(context).primaryColor,
        enableDefaultShare: true,
        enableUrlBarHiding: true,
        showPageTitle: true,
        animation: new CustomTabsAnimation.slideIn(),
        extraCustomTabs: <String>[
          'org.gnu.icecat',
          'org.mozilla.firefox',
          'com.microsoft.emmx',
        ],
      ),
    );
  } catch (e) {
    debugPrint(e.toString());
  }
}
