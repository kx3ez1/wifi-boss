import 'package:flutter/material.dart';
import 'package:wifi_boss/main.dart';
import 'package:wifi_boss/main_methods.dart';
import 'package:wifi_boss/user_data.dart';

import 'db_operations.dart';

class SavedPasswords extends StatefulWidget {
  const SavedPasswords({Key? key}) : super(key: key);

  @override
  _SavedPasswordsState createState() => _SavedPasswordsState();
}

class _SavedPasswordsState extends State<SavedPasswords> {
  DbOperations? dbOperations;

  @override
  void initState() {
    super.initState();
    dbOperations = DbOperations();
    loadCredentialList1();
  }

  loadCredentialList1() async {
    CredentialsData.items2 = await dbOperations!.getDataList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            loadCredentialList1();
            Navigator.pushReplacementNamed(context, '/');
            MyVariables.navBarSelectedOption = 0;
          },
        ),
        // leading: InkWell(
        //     onTap: () {
        //       Navigator.pushReplacementNamed(context, '/');
        //       MyVariables.navBarSelectedOption = 0;
        //     },
        //     child: const Icon(Icons.arrow_back)),
        title: const Text('Saved Passwords'),
      ),
      bottomNavigationBar: const MyBottomNav(),
      body: CredentialsData.items2.isNotEmpty
          ? ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 1.0,
                );
              },
              itemCount: CredentialsData.items2.length,
              itemBuilder: (context, index) {
                var data = CredentialsData.items2;
                var username1 = data[index].username.toString();
                var password1 = data[index].password.toString();
                return Dismissible(
                  key: Key(CredentialsData.items2[index].id.toString()),
                  onDismissed: (direction) async {
                    await dbOperations!.delete(CredentialsNoId(
                        username: username1, password: password1));
                    loadCredentialList1();
                  },
                  background: Container(
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.delete),
                        Icon(Icons.delete),
                      ],
                    ),
                  ),
                  child: ListTile(
                    onTap: () {
                      Future.delayed(const Duration(milliseconds: 200), () {});

                      MyVariables.username2 = username1;
                      MyVariables.password2 = password1;

                      MyVariables.navBarSelectedOption = 0;
                      setState(() {});

                      Navigator.pushReplacementNamed(context, '/');
                    },
                    contentPadding: const EdgeInsets.all(20.0),
                    trailing: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                      child: const Text('Delete'),
                      onPressed: () async {
                        await dbOperations!.delete(CredentialsNoId(
                            username: username1, password: password1));
                        loadCredentialList1();
                      },
                    ),
                    subtitle: Text(password1),
                    // leading: Column(
                    //   children: [
                    //     Text(username,style: const TextStyle(
                    //     ),
                    //     ),
                    //     Text(password,style: const TextStyle(
                    //     ),
                    //     ),
                    //   ],
                    // ),
                    title: Text(username1),
                  ),
                );
              },
            )
          : const ListTile(
              leading: Text('No Saved Passwords'),
            ),
    );
  }
}
