import 'package:flutter/material.dart';
import 'package:wifi_boss/main_methods.dart';
import 'package:wifi_boss/user_data.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
                MyVariables.navBarSelectedOption = 0;
              },
              child: const Icon(Icons.arrow_back)),
          title: const Text('Settings')),
      bottomNavigationBar: const MyBottomNav(),
    );
  }
}
