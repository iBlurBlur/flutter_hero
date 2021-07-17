import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hero/src/configs/routes/app_route.dart';
import 'package:flutter_hero/src/utils/services/local_storage_service.dart';
import 'package:flutter_hero/src/viewmodels/menu_viewmodel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildProfile(),
          ..._buildMainMenu(context),
          Spacer(),
          _buildLogout(context)
        ],
      ),
    );
  }

  UserAccountsDrawerHeader _buildProfile() => UserAccountsDrawerHeader(
        accountName: Text('iBlur Blur'),
        accountEmail: Text('tanakorn.ngam@gmail.com'),
        currentAccountPicture: Container(
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://avatars1.githubusercontent.com/u/35045612?s=400&v=4',
            ),
            backgroundColor: Colors.transparent,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      );

  List<ListTile> _buildMainMenu(BuildContext context) {
    final menuViewModel = MenuViewModel()..setInBox = '99';
    return menuViewModel.items
        .map((item) => ListTile(
              title: Text(
                item.title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                ),
              ),
              leading: _buildBadge(
                item.notification ?? '',
                icon: item.icon,
                iconColor: item.iconColor,
              ),
              onTap: () => item.navigator(context),
            ))
        .toList();
  }

  Badge _buildBadge(
    String notification, {
    required IconData icon,
    required Color iconColor,
  }) {
    final isMaxNotification = notification.length >= 3;
    return Badge(
      toAnimate: false,
      shape: isMaxNotification ? BadgeShape.square : BadgeShape.circle,
      borderRadius:
          isMaxNotification ? BorderRadius.circular(8) : BorderRadius.zero,
      showBadge: notification.isNotEmpty,
      badgeContent: Text(
        notification.length >= 4 ? '999+' : notification,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      badgeColor: Colors.red,
      child: FaIcon(
        icon,
        color: iconColor,
      ),
    );
  }

  SafeArea _buildLogout(BuildContext context) => SafeArea(
        child: ListTile(
          title: Text('Log out'),
          leading: Icon(
            FontAwesomeIcons.signOutAlt,
            color: Colors.grey,
          ),
          onTap: () => _logout(context),
        ),
      );

  void _logout(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await LocalStorageService().removeToken();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoute.login,
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
