import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

/// Your google auth credentials
const _credentials = r'''
{
  "type": "service_account",
  "project_id": "myflutterapp-335411",
  "private_key_id": "4b353e5638341c4143bf57235e95bf04759666e0",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDIl9XMcke2AeYm\nBLtRdfrc4DKEoiG66qMPqGT+dIyguI3bKqRex6+zssUDwbDVeE6XmmnO0Dk35wjD\ndv/XP7hg24nH4y77UgUtIZrpOuImhLJiCJWsR6tq7bQFXsLWbwwjvOgKm1+VfyQd\nSKkB8uOKHuUfwbMYLvXYviBl+9grJczFKfZs2XtzE5HZij4P1GsfGd5fCt9tNK26\nXSK2B4eFbWc1EzEhUoN5oQVslgvsXIooG98riLiasGyfcrCmRBTzeeNW2YPQnz3c\npvMERPnQEG9WX4pceSdCJS64Vszb0hcArZ7HtX5D0sOJzJicBqhi1MaV3eMa5rqa\n/T31QBpvAgMBAAECggEABLDMPpIjjCWCOLxelvqPya9ybviNml3XP0v8RJj8GtwF\n8SyPmGnJ+YVCJyLV3EAKcnAZbk0fMWf1JAD53ZIvYRBxKdvtotHZriL9iNuoIydy\nNmml+lfYsdDqJz/+hV4mZgWKVYkplIjbEtY6oYGJAZdUW0g/xF6AwDc98bSQav3W\nK72gFZWTfVHP+lYGMqdlM2EoUfRgkjAsYfaqHS+ujX9MSLksUSqmRurLCU+bOIqQ\nir4VUd1s2yHvfxqzat2p758eXKO+kUT4TzXLddZsLXiXjXas4Dd9Qu5CdFXkg4AG\n/5NBdTUjImh14Ie737+4dSbacpsJSXAxb4ikF1n4CQKBgQDxrp9FSzGGpEnbiU7A\nAdqudINCQagjhKbDBlsZ1V/7/SDPe0ePMpXIkchW4c4IeLUgomkQgepUJ3EkmNYL\nxNct/8KvGcKlVyRxcHEx8jdzkRTyrv0K5bFVpangryNfMgdNeeZjMrmMEspM6Dc+\nJN0ZKGbQezhimIKC/pH4kaljGQKBgQDUeg1vh8dZTdxJypgdTfBoGDHuMycCpFu1\nDt+xiWgG81Fj2qCccmBHYZy4NqYuW7fvnCU5ahmNiL9ilGbvSfvCvRUA/tixXpQt\nMk+I1kT7R8p0YC89v7get4ow9C2wwCtsoYwCSncWGWFI8f+HJ0xFVMVk3QI7MF/l\nIqD0tNjixwKBgAuqDN/QSDyiUzo4P0e/DynaT7dz6cSFE3NYLC9r/+zug5Xf8k0z\n+MysVIn07fe0s7E2hXGZg5C6Mpi8k6APyP7cWC4RRTarpQOglKX/dbOrLeKklWvg\nOBXVIATLDx76ECYqGvdwrEnZYlAh6QCj0NP1AjlPqSIBEFN4K91eUlmJAoGBAKKY\n5D89QKhulO1DRDTot9hw64TFUE0NScC8qSJLbHglK1umqtIOFO+LG0s9Rt6jAZcz\nfqj5MKTGyO6/ciYcD7VuzOv+GgVhwzLzFTo5/n/s6Fk2YfB3DoczHWVo9q4T4Sc4\nWNRH9+nJclFIH6tlv1AvFv+gwVxaIIhQf6vD2VVxAoGBAOzmzX62nuqFI2UOnvwr\nUyEqT3a87MpWIpgN96AgCyrYagCTPe11wLxanwyE1Rj9MuG968E+7Rut87L30fEg\n54QnhQfjK+tVS5kOdtdpQLkQouK4tKJvxzXSZmS1rdehLRUmMDalH/FP27oVlGnH\nSdYQOHTMgRt32MBjiUXhIbyB\n-----END PRIVATE KEY-----\n",
  "client_email": "bharat@myflutterapp-335411.iam.gserviceaccount.com",
  "client_id": "108785710829387011137",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/bharat%40myflutterapp-335411.iam.gserviceaccount.com"
}
''';

/// Your spreadsheet id
///
/// It can be found in the link to your spreadsheet -
/// link looks like so https://docs.google.com/spreadsheets/d/YOUR_SPREADSHEET_ID/edit#gid=0
/// [YOUR_SPREADSHEET_ID] in the path is the id your need
const _spreadsheetId = '1eMYWvevcuoflPGnnNx0c-1u15GPGqvBFS_bQLMf1Shs';

loadData() async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  final ss = await gsheets.spreadsheet(_spreadsheetId);

  // get worksheet by its title
  var sheet = ss.worksheetByTitle('example');

  // create worksheet if it does not exist yet
  sheet ??= await ss.addWorksheet('example');

  var data = [1, 2, 3, 4, 5, 6, 7];

  await sheet.values.insertColumn(1, data);
}

class GoogleDataManager extends StatefulWidget {
  const GoogleDataManager({Key? key}) : super(key: key);

  @override
  _GoogleDataManagerState createState() => _GoogleDataManagerState();
}

class _GoogleDataManagerState extends State<GoogleDataManager> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Hello world'),
    );
  }
}
