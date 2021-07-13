import 'package:flutter/material.dart';
import 'package:flutter_hero/src/viewmodels/sso_viewmodel.dart';

class SingleSignOn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const SSOViewModel()
            .items
            .map((item) => _buildButton(item))
            .toList(),
      ),
    );
  }

  FloatingActionButton _buildButton(SSO item) => FloatingActionButton(
        heroTag: item.hashCode,
        backgroundColor: item.backgroundColor,
        onPressed: item.onPress,
        child: Icon(
          item.icon,
          color: Colors.white,
        ),
      );
}
