import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wifi_boss/http_requests_.dart';
import 'package:wifi_boss/main.dart';
import 'package:wifi_boss/main_methods.dart';
import 'package:wifi_boss/user_data.dart';

class ConnectedWifi extends StatefulWidget {
  final String connectedMsg;
  const ConnectedWifi({
    Key? key,
    required this.connectedMsg,
  }) : super(key: key);

  @override
  _ConnectedWifiState createState() => _ConnectedWifiState();
}

class _ConnectedWifiState extends State<ConnectedWifi> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('dispose called connected');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            loadCredentialList();
            MyVariables.username = (CredentialsData.items.isNotEmpty? CredentialsData.items[0].username:'')!;
            MyVariables.password = (CredentialsData.items.isNotEmpty? CredentialsData.items[0].password:'')!;
            MyVariables.errorMsg = '';
            MyVariables.connectedMsg = '';
            Navigator.pop(context);
          },
        ),
        title: const Text('wifi connected'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(widget.connectedMsg),
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                'images/check-circle.png',
                scale: 1.2,
              ),
              SizedBox(
                height: 50,
              ),
              Image.asset(
                'images/dance_.gif',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
