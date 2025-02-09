import 'package:googleapis_auth/auth_io.dart';

// ignore: camel_case_types
class get_server_key {
  // ignore: non_constant_identifier_names
  Future<String> server_token() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "",
          "private_key_id": "7",
          "private_key":"",
          "client_email":
              "firebase-adminsdk-zg1es@propertypall.iam.gserviceaccount.com",
          "client_id": "",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "",
          "auth_provider_x509_cert_url":
              "",
          "client_x509_cert_url":
              "",
          "universe_domain": "googleapis.com"
        }),
        scopes);
    final accessserverkey = client.credentials.accessToken.data;
    return accessserverkey;
  }
}
