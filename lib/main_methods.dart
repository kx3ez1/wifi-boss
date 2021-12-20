import 'package:flutter/material.dart';
import 'package:wifi_boss/google_data.dart';
import 'package:wifi_boss/main.dart';
import 'package:wifi_boss/saved_passwords.dart';
import 'package:wifi_boss/screens/connected.dart';
import 'package:wifi_boss/screens/error_connecting.dart';
import 'package:wifi_boss/screens/settings.dart';
import 'package:wifi_boss/user_data.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currTheme,
      builder: (BuildContext context, value, Widget? child) {
        return MaterialApp(
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: currTheme.value,
            initialRoute: '/',
            routes: {
              '/': (context) => const MyHome(),
              '/second': (context) => const SavedPasswords(),
              '/settings': (context) => const SettingsPage(),
              '/google': (context) => const GoogleDataManager(),
              '/connected': (context) => ConnectedWifi(connectedMsg: MyVariables.connectedMsg,),
              '/error': (context) => ConnectingErrorWifi(
                    error: MyVariables.errorMsg,
                  ),
            });
      },
    );
  }
}

class MyBottomNav extends StatefulWidget {
  const MyBottomNav({Key? key}) : super(key: key);

  @override
  State<MyBottomNav> createState() => _MyBottomNavState();
}

class _MyBottomNavState extends State<MyBottomNav> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        MyVariables.navBarSelectedOption = value;
        setState(() {});
        if (value == 0) {
          Navigator.pushReplacementNamed(context, '/');
        } else if (value == 1) {
          Navigator.pushReplacementNamed(context, '/second');
        } else {
          Navigator.pushReplacementNamed(context, '/settings');
        }
      },
      currentIndex: MyVariables.navBarSelectedOption,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.password),
          label: "Passwords",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings",
        ),
      ],
    );
  }
}
