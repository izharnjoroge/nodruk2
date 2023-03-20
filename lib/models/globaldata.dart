import 'package:cloud_firestore/cloud_firestore.dart';

class GlobalData {
  String id;
  String token;
  String businessEmail;

  String callBackUrl;
  String cancelledUrl;
  String demoClientKey;

  GlobalData({
    this.id,
    this.token,
    this.businessEmail,
    this.callBackUrl,
    this.cancelledUrl,
    this.demoClientKey,
  });
  factory GlobalData.fromDoc(DocumentSnapshot json) {
    return GlobalData(
      id: json.id,
      businessEmail: json['BusinessEmail'],
      token: json['token'],
      callBackUrl: json['CallBackUrl'],
      cancelledUrl: json['CancelledUrl'],
      demoClientKey: json['demoClientKey'],
    );
  }
}
