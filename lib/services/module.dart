import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// ignore: missing_return
Future request({
  Uri url,
  Map<String, dynamic> data,
}) async {
  http.Response response;
  try {
    response = await http.post(
      url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // debugPrint(jsonDecode(response.body));
      return response.body;
    } else {
      return jsonDecode(jsonEncode({
        "status": "error",
        "message": "error occured (${response.statusCode})"
      }));
    }
  } on TimeoutException catch (e) {
    return 'Operation timed out ${e.message}';
  } on SocketException catch (e) {
    return 'Please check your internet connection. ${e.message}';
  } on Error {
    return 'An error occurred, please try again later.';
  }
}

void showInSnackBar(String txt, context) {
  final snackBar = SnackBar(
    content: Text(txt.toString()),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
