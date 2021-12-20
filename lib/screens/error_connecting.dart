import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wifi_boss/main.dart';
import 'package:wifi_boss/user_data.dart';

import '../http_requests_.dart';

class ConnectingErrorWifi extends StatefulWidget {
  final String error;
  const ConnectingErrorWifi({Key? key, required this.error}) : super(key: key);

  @override
  _ConnectingErrorWifiState createState() => _ConnectingErrorWifiState();
}

class _ConnectingErrorWifiState extends State<ConnectingErrorWifi> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('dispose called on errorScreen Page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            loadCredentialList();
            MyVariables.username = usernameController.text;
            MyVariables.password = passwordController.text;
            MyVariables.errorMsg = '';
            MyVariables.connectedMsg = '';
            Navigator.pop(context);
          },
        ),
        title: const Text('error in connecting'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('images/jagan.gif',scale: 1.4,),
              const SizedBox(
                height: 10,
              ),
              Text(widget.error),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: const Text('Retry'))
            ],
          ),
        ),
      ),
    );
  }
}
