import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:mrpmile/utils/Utils.dart';
import 'package:mrpmile/views/ActivityLogin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ActivityPrivacyPolicy extends StatefulWidget {
  @override
  _ActivityPrivacyPolicyState createState() => _ActivityPrivacyPolicyState();
}

class _ActivityPrivacyPolicyState extends State<ActivityPrivacyPolicy> {
  String _pdfUrl;
  File _pdfFile;
  bool _isLoading = true;

  @override
  void initState() {
    Firestore.instance
        .collection('privacy_policy')
        .document('policy')
        .get()
        .then((documentSnapshot) async {
      _pdfUrl = documentSnapshot['privacy_policy_url'];
      _pdfFile = await _getFileFromUrl(_pdfUrl);
      setState(() {
        _isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        Utils.showToast(message: error.message);
        _isLoading = false;
      });
    });
    super.initState();
  }

  Future<File> _getFileFromUrl(String url) async {
    try {
      var data = await http.get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/mypdfonline.pdf");
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Utils.loadingContainer()
        : WillPopScope(
            child: Scaffold(
              appBar: AppBar(
                title: Text('Privacy Policy'),
                leading: IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    Utils.changeScreen(context, ActivityLogin());
                  },
                ),
              ),
              body: PDFView(
                filePath: _pdfFile.path,
                enableSwipe: true,
              ),
            ),
            onWillPop: () {
              Utils.changeScreen(context, ActivityLogin());
            },
          );
  }
}
