import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wifi_boss/main.dart';

class Profiles extends StatefulWidget {
  const Profiles({Key? key}) : super(key: key);

  @override
  _ProfilesState createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const DrawerHeader(
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Developers',
                    style: TextStyle(fontSize: 25),
                  ))),
          ListTile(
              onTap: () {
                genProfile(context, 'Bharat Reddy', 'images/bharat.jpg',
                    wapp:
                        'https://api.whatsapp.com/send/?phone=+916303374750&text=hi',
                    insta: 'https://www.instagram.com/soulbeats/');
              },
              focusColor: Colors.green,
              trailing: InkWell(
                  onTap: () {
                    genProfile(context, 'Bharat Reddy', 'images/bharat.jpg');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(Icons.account_circle),
                  )),
              title: const Text('Bharat Reddy'),
              subtitle: const Text('Developer,\nProject Head'),
              //leading: CircleAvatar(foregroundImage: AssetImage('images/pavan.jpeg',),)
              leading: Image.asset('images/bharat.jpg')),
          ListTile(
              onTap: () {
                genProfile(context, 'George Reddy', 'images/george.jpeg');
              },
              focusColor: Colors.green,
              trailing: InkWell(
                  onTap: () {
                    genProfile(context, 'George Reddy', 'images/george.jpeg');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(Icons.account_circle),
                  )),
              title: const Text('George Reddy'),
              subtitle: const Text('Android Designer'),
              //leading: CircleAvatar(foregroundImage: AssetImage('images/pavan.jpeg',),)
              leading: Image.asset('images/george.jpeg')),
          ListTile(
              onTap: () {
                genProfile(context, 'AKshay Reddy', 'images/akshay.jpg');
              },
              focusColor: Colors.green,
              trailing: InkWell(
                  onTap: () {
                    genProfile(context, 'AKshay Reddy', 'images/akshay.jpg');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(Icons.account_circle),
                  )),
              title: const Text('Akshay Reddy'),
              subtitle: const Text('Project Planner'),
              //leading: CircleAvatar(foregroundImage: AssetImage('images/pavan.jpeg',),)
              leading: Image.asset('images/akshay.jpg')),
          ListTile(
              onTap: () {
                genProfile(context, 'Pavan', 'images/pavan.jpeg');
              },
              focusColor: Colors.green,
              trailing: InkWell(
                  onTap: () {
                    genProfile(context, 'Pavan', 'images/pavan.jpeg');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(Icons.account_circle),
                  )),
              title: const Text('Pavan'),
              subtitle: const Text('Producer'),
              //leading: CircleAvatar(foregroundImage: AssetImage('images/pavan.jpeg',),)
              leading: Image.asset('images/pavan.jpeg')),
          ListTile(
              onTap: () {
                genProfile(context, 'Nageswar', 'images/nageswar.jpeg');
              },
              focusColor: Colors.green,
              trailing: InkWell(
                  onTap: () {
                    genProfile(context, 'Nageswar', 'images/nageswar.jpeg');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(Icons.account_circle),
                  )),
              title: const Text('Nageswar'),
              subtitle: const Text('Test Head'),
              //leading: CircleAvatar(foregroundImage: AssetImage('images/pavan.jpeg',),)
              leading: Image.asset('images/nageswar.jpeg')),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CupertinoButton(
                child: Row(
                  children: const [
                    Icon(Icons.mail_rounded),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Contact'),
                  ],
                ),
                onPressed: () {
                  _launchURL('mailto:vtu14201@veltech.edu.in');
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

genProfile(context, name, image, {insta = '', fb = '', wapp = ''}) {
  return showDialog(
    context: context,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Dialog(
            backgroundColor: currTheme.value.toString() == "ThemeMode.dark"
                ? Colors.black.withOpacity(0.3)
                : Colors.white.withOpacity(0.8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(image),
                ),
                Text(
                  name,
                  style: const TextStyle(fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    insta == ''
                        ? Container()
                        : IconButton(
                            color: Colors.red,
                            onPressed: () async {
                              if (insta == '') {
                              } else {
                                _launchURL(insta);
                              }
                            },
                            icon: const FaIcon(FontAwesomeIcons.instagram)),
                    fb == ''
                        ? Container()
                        : IconButton(
                            color: Colors.red,
                            onPressed: () async {
                              if (insta == '') {
                              } else {
                                _launchURL(fb);
                              }
                            },
                            icon: const FaIcon(FontAwesomeIcons.facebook)),
                    wapp == ''
                        ? Container()
                        : IconButton(
                            color: Colors.red,
                            onPressed: () async {
                              if (insta == '') {
                              } else {
                                _launchURL(wapp);
                              }
                            },
                            icon: const FaIcon(FontAwesomeIcons.whatsapp)),
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    ),
  );
}

void _launchURL(_url) async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}
