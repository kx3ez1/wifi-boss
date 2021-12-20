import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wifi_boss/http_requests_.dart';

import 'package:wifi_boss/main_methods.dart';
import 'package:wifi_boss/user_data.dart';

import 'db_operations.dart';
import 'package:wifi_boss/screens/drawer_desc.dart';

void main() {
  runApp(const MyApp());
}

final ValueNotifier<ThemeMode> currTheme = ValueNotifier(ThemeMode.light);

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

DbOperations? dbOperations;

bool _showPass = true;

bool loading = false;

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('@didChangeDependencies');
  }

  @override
  void didUpdateWidget(covariant MyHome oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('@didUpdateWidget');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose called');
  }

  @override
  void initState() {
    super.initState();
    print('init state @@ main.dart');
    dbOperations = DbOperations();

    loadCredentialList();

    Future.delayed(const Duration(milliseconds: 200), () {
      if(MyVariables.username2.isNotEmpty && MyVariables.password2.isNotEmpty) {
        usernameController.text = MyVariables.username2;
        passwordController.text = MyVariables.password2;
        MyVariables.username = MyVariables.username2;
        MyVariables.password = MyVariables.password2;
        print(usernameController.text);
        print(passwordController.text);
        print(MyVariables.username2);
        print(MyVariables.password2);
      }
      else if(usernameController.text.isNotEmpty && passwordController.text.isNotEmpty){
        usernameController.text = (CredentialsData.items.isNotEmpty? CredentialsData.items[0].username:'')!;
        passwordController.text = (CredentialsData.items.isNotEmpty? CredentialsData.items[0].password:'')!;
        MyVariables.username = (CredentialsData.items.isNotEmpty? CredentialsData.items[0].username:'')!;
        MyVariables.password = (CredentialsData.items.isNotEmpty? CredentialsData.items[0].password:'')!;
      }
      if (MediaQuery.of(context).platformBrightness.toString() ==
          "Brightness.light") {
        MyVariables.checkBrightnessMode = false;
      } else {
        MyVariables.checkBrightnessMode = true;
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Profiles(),
        appBar: AppBar(
          title: const Text('Wifi Boss'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  currTheme.value = currTheme.value == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
                    print(currTheme.value);
                    setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: MyVariables.checkBrightnessMode
                      ? const Icon(Icons.wb_sunny)
                      : const Icon(Icons.wb_sunny_outlined),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: const MyBottomNav(),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Column(children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0)),
                    border: Border.all(
                      color: currTheme.value.toString() == "ThemeMode.dark"
                          ? Colors.white
                          : Colors.black38,
                    ),
                  ),
                  child: Column(children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0)),
                        color: Color(0x8B999999),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.asset(
                            "images/uploadedwebclientlogo.jpg",
                          ),
                        ),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              loading
                                  ? const Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: CircularProgressIndicator(),
                                    )
                                  : Column(
                                      children: [
                                        TextField(
                                          controller: usernameController,
                                          decoration: const InputDecoration(
                                              labelText: 'username',
                                              focusColor: Colors.white,
                                              hoverColor: Colors.white,
                                              icon: Icon(Icons.person)),
                                          onChanged: (value) {
                                            MyVariables.username = value.toString();
                                          },
                                        ),
                                        TextField(
                                          controller: passwordController,
                                          obscureText: _showPass,
                                          decoration: InputDecoration(
                                            labelText: 'password',
                                            hoverColor: Colors.red,
                                            icon: const Icon(Icons.lock),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _showPass
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.redAccent,
                                                size: 20.0,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _showPass = !_showPass;
                                                });
                                              },
                                            ),
                                          ),
                                          onChanged: (value) {
                                            MyVariables.password = value.toString();
                                          },
                                        ),
                                      ],
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  loading
                                      ? Container()
                                      : CupertinoButton(
                                          onPressed: () async {
                                            print('\n<=${'-' * 30}=>');

                                            if(MyVariables.username.isEmpty || MyVariables.password.isEmpty){
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('username or password are invalid')));
                                            }else{

                                            loading = !loading;

                                            setState(() {});

                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 5000),
                                                () {});

                                            if (CredentialsData.items.isNotEmpty?
                                            CredentialsData.items[0].username != null:false) {
                                              if (MyVariables.username == '' &&
                                                  MyVariables.password == '') {
                                                MyVariables.username = CredentialsData
                                                    .items[0].username
                                                    .toString();
                                                MyVariables.password = CredentialsData
                                                    .items[0].password
                                                    .toString();
                                              }
                                              print('@@${MyVariables.username}');
                                              print('@@${MyVariables.password}');
                                              print(
                                                  'username text @@${usernameController.text}');
                                              print(
                                                  'password text@@${passwordController.text}');
                                              print(
                                                  'username @@${usernameController.value}');
                                              print(
                                                  'password @@${passwordController.value}');
                                              // username ??=
                                              //     usernameController.value;
                                              // password ??=
                                              //     passwordController.value;
                                            }
                                            //no response for 7sec
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 7000), () {
                                              if (loading == true) {
                                                loading = false;
                                                MyVariables.errorMsg =
                                                    'Check your connection';
                                                Navigator.pushNamed(
                                                    context, '/error');
                                              }
                                            });

                                            print('@@${MyVariables.username}');
                                            print('@@${MyVariables.password}');

                                            //wifi login
                                            var response =
                                                await wifiLoginRequest();

                                            if (response.body.toString().contains(
                                                'You have reached the maximum login')) {
                                              MyVariables.errorMsg =
                                                  'You have reached the maximum login';
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('password saved success!')));
                                              dbOperations!
                                                  .insert(CredentialsNoId(
                                                      username: MyVariables.username,
                                                      password: MyVariables.password))
                                                  .then(
                                                      (value) => print(value));

                                              loadCredentialList();
                                              loading = !loading;
                                              setState(() {});
                                              Navigator.pushNamed(
                                                context,
                                                '/error',
                                              );
                                            }
                                            if (response.body
                                                .toString()
                                                .contains(
                                                    'You are signed in as')) {
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('password saved success!')));
                                              MyVariables.connectedMsg =
                                                  'You are signed in as ${MyVariables.username}';

                                              dbOperations!
                                                  .insert(CredentialsNoId(
                                                      username: MyVariables.username,
                                                      password: MyVariables.password))
                                                  .then(
                                                      (value) => print(value));
                                              loadCredentialList();
                                              loading = !loading;
                                              setState(() {});
                                              Navigator.pushNamed(
                                                context,
                                                '/connected',
                                              );
                                            }
                                            if (response.body.toString().contains(
                                                'Login failed. Invalid user name/password.')) {
                                              MyVariables.errorMsg =
                                                  'Login failed. Invalid user name/password.';

                                              loadCredentialList();
                                              loading = !loading;
                                              setState(() {});
                                              Navigator.pushNamed(
                                                context,
                                                '/error',
                                              );
                                            }

                                            if (response.body.toString().contains(
                                                'Unable to access auth service')) {
                                              MyVariables.errorMsg =
                                                  'Unable to access auth service. Try After some time.';

                                              loadCredentialList();
                                              loading = !loading;
                                              setState(() {});
                                              Navigator.pushNamed(
                                                context,
                                                '/error',
                                              );
                                            }

                                            if (response.body.toString().contains(
                                                'check username & password')) {
                                              MyVariables.errorMsg =
                                              'check username & password.';

                                              loadCredentialList();
                                              loading = !loading;
                                              setState(() {});
                                              Navigator.pushNamed(
                                                context,
                                                '/error',
                                              );
                                            }

                                            print(
                                                'Response status: ${response.statusCode}');
                                            print(
                                                'Response body: ${response.body}');

                                            print('@@ clicked..');

                                            print(MyVariables.username);
                                            print(MyVariables.password);

                                            CredentialsData.checkData =
                                                await dbOperations!
                                                    .checkData(CredentialsNoId(
                                              username: MyVariables.username,
                                              password: MyVariables.password,
                                            ));
                                            print('msg $MyVariables.msg');
                                          }
                                            },
                                          color: Colors.green,
                                          child: const Text('Sign In'),
                                        ),
                                ],
                              ),
                            ]))
                  ]))
            ])));
  }
}
