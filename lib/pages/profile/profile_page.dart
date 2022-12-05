import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/common_widgets/app_app_bar.dart';
import 'package:shop_app/providers/user_provider.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile-page';

  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Profile'),
      body: Column(
        children: [
          SettingItem(appTheme: appTheme),
        ],
      ),
    );
  }
}

class SettingItem extends StatefulWidget {
  const SettingItem({
    Key? key,
    required this.appTheme,
  }) : super(key: key);

  final ThemeData appTheme;

  @override
  _SettingItemState createState() => _SettingItemState();
}

class _SettingItemState extends State<SettingItem> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) => ListTile(
        //onTap: (){},
        leading: AnimatedCrossFade(
          duration: Duration(milliseconds: 300),
          firstChild: Icon(
            Icons.light_mode_rounded,
            color: widget.appTheme.accentColor,
          ),
          secondChild:Icon(
            Icons.dark_mode_rounded,
            color: widget.appTheme.accentColor,
          ),
          crossFadeState: userProvider.iSDarkMode == false ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstCurve: Curves.bounceInOut,
          secondCurve: Curves.easeIn,
        ),
        title: Text('Dark Mode'),
        trailing: Switch(
          value: userProvider.iSDarkMode,
          onChanged: (bool value) {
            userProvider.changeIsDarkModeValue(value);
          },
        ),
      ),
    );
  }
}

//Icon(
//           userProvider.iSDarkMode == false ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
//           color: widget.appTheme.accentColor,
//         ),
