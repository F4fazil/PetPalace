import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/googleapis_auth.dart';

class NotificationService {
  final String _fcmUrl =
      'https://fcm.googleapis.com/v1/projects/propertypall/messages:send';

  // Notification  For all users except current
  Future<void> sendNotificationToAllUsers(String title, String body) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final currentUserRef = FirebaseFirestore.instance
        .collection('usertokens')
        .doc(currentUser.uid);
    final currentUserDoc = await currentUserRef.get();
    final currentUserToken = currentUserDoc['token'];
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('usertokens').get();
    for (var doc in snapshot.docs) {
      final token = doc['token'];
      if (token != currentUserToken) {
         await sendNotification(title, body, token);
      }
    }
  }

  // Msg For specific person
  Future<void> sendMessageNotification(
      String title, String body, String recipientUid) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    // Fetch the recipient's token using their UID
    final recipientRef =
        FirebaseFirestore.instance.collection('usertokens').doc(recipientUid);
    final recipientDoc = await recipientRef.get();

    if (recipientDoc.exists) {
      final recipientToken = recipientDoc['token'];

      // Check if the recipient token is not the same as the current user's token
      if (recipientToken != null) {
        await sendNotification(title, body, recipientToken);
      }
    }
  }

  // server_key_fetching_function
  Future<String> getAuthToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "",
          "private_key_id": "",
         "client_email":
              "firebase-adminsdk-zg1es@propertypall.iam.gserviceaccount.com",
          "client_id": "109988975729385230394",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-zg1es%40propertypall.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        scopes);
    final accessserverkey = client.credentials.accessToken.data;
    return accessserverkey;
  }

 Future<void> sendNotification(String title, String body, String token) async {
  try {
    // Get the OAuth2 token
    final String authToken = await getAuthToken();
    if (authToken.isEmpty) {
      print("Failed to get auth token.");
      return;
    }

    final response = await http.post(
      Uri.parse(_fcmUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken', // Use the OAuth2 token here
      },
      body: jsonEncode(
        <String, dynamic>{
          'message': <String, dynamic>{
            'token': token,
            'notification': <String, dynamic>{
              'title': title,
              'body': body,
            },
            'android': <String, dynamic>{
              'priority': 'high',
              'notification': <String, dynamic>{
                'icon': 'ic_launcher',  
              },
            },
          },
        },
      ),
    );

    if (response.statusCode == 200) {
      print("sent successfully");
    } else {
      print('Failed to send notification. Response: ${response.body}');
    }
  } catch (e) {
    print('Error sending notification: $e');
  }
}

}
