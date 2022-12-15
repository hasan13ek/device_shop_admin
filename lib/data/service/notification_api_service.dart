import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:http/http.dart';

class NotificationApiService {
  static Future<int> sendNotificationToUser({required  String fcmToken, required String message}) async {
    String key =
        "key=AAAAKHesbks:APA91bET9xGiVkIuytGRMCsxIfaZLauO1h5Me2DOFxn9Gl4zhgQ9VV3cQtkabdejJkTbKDoHxfVymkNmcY8eo-5Ss4s6AZLcsU2D2t-ZdwUMoX8oM3r8gRLF7c6YzYpSA4CvhtoeRKE9";
    var body = {
      "to": fcmToken,
      "notification": {
        "title": "Diqqat! Notification keldi",
        "body": message
      },
      "data": {
        "name": "Abdulloh",
        "age": 22,
        "job": "Programmer",
        "route": "chat"
      }
    };

    Uri uri = Uri.parse("https://fcm.googleapis.com/fcm/send");

    try {
      Response response = await https.post(
        uri,
        headers: {"Authorization": key, "Content-Type": "application/json"},
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        var t = jsonDecode(response.body);
        print("RESPONSE:$t");
        return jsonDecode(response.body)["success"] as int;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<String> sendNotificationToAll(String topicName) async {
    String key =
        "key=AAAAKHesbks:APA91bET9xGiVkIuytGRMCsxIfaZLauO1h5Me2DOFxn9Gl4zhgQ9VV3cQtkabdejJkTbKDoHxfVymkNmcY8eo-5Ss4s6AZLcsU2D2t-ZdwUMoX8oM3r8gRLF7c6YzYpSA4CvhtoeRKE9";

    Map<String, dynamic> body = {
      "to": "/topics/$topicName",
      "notification": {
        "title": "Diqqat! Notification keldi",
        "body": "Bu notofication body"
      },
      "data": {
        "name": "Abdulloh",
        "age": 22,
        "job": "Programmer",
        "route": "chat"
      }
    };

    Uri uri = Uri.parse("https://fcm.googleapis.com/fcm/send");
    try {
      Response response = await https.post(
        uri,
        headers: {
          "Authorization": key,
          "Content-Type": "application/json",
        },
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["message_id"].toString();
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}