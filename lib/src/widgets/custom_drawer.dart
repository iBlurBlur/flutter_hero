import 'package:flutter/material.dart';
import 'package:flutter_hero/src/configs/routes/app_route.dart';
import 'package:flutter_hero/src/utils/services/local_storage_service.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Spacer(),
          ListTile(
            onTap: () => _logout(context),
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: Text('Are you sure to logout?'),
          actions: <Widget>[
            TextButton(
              child: Text('cancel'),
              onPressed: () async {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: Text(
                'logout',
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
