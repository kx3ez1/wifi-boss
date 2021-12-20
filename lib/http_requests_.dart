import 'package:wifi_boss/main.dart';
import 'package:wifi_boss/user_data.dart';

import 'package:http/http.dart' as http;

getGoogleStatus() async {
  var url1 = Uri.parse('http://google.com');
  var response1 = await http.get(url1);
  if (response1.statusCode == 200 &&
      response1.body.toString().contains('<title>Google</title>')) {
    return true;
  } else {
    return false;
  }
}

loadCredentialList() async {
  CredentialsData.items = await dbOperations!.getDataList();

  if (MyVariables.username.isEmpty) {
    usernameController.text =
        CredentialsData.items[0].username!; //initial value of username field
    passwordController.text = CredentialsData.items[0].password!;
  } else {
    usernameController.text = MyVariables.username;
    passwordController.text = MyVariables.password;
  }
}

wifiLoginRequest() async {
  if(MyVariables.username.isNotEmpty && MyVariables.password.isNotEmpty) {
    var url = Uri.parse('http://10.10.1.5:8090/login.xml');
    var response = await http.post(url, headers: {
      'User-Agent':
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:95.0) Gecko/20100101 Firefox/95.0',
      'Accept': '*/*',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Origin': 'http://10.10.1.5:8090',
      'DNT': '1',
      'Connection': 'keep-alive',
      'Referer': 'http://10.10.1.5:8090/',
      'Accept-Encoding': 'gzip, deflate',
    }, body: {
      "mode": "191",
      "username": MyVariables.username,
      "password": MyVariables.password,
      "a": "${DateTime
          .now()
          .millisecondsSinceEpoch}",
      "producttype": "0"
    });
    print('HttpRequest');
    print('!!${MyVariables.username}');
    print('!!${MyVariables.password}');
    return response;
  }
  else{
    print('HttpRequest');
    print('!!${MyVariables.username}');
    print('!!${MyVariables.password}');
    return http.Response('check username & password', 404);
  }
}
