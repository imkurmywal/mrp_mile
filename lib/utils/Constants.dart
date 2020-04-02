import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Constants {
  static final maroonColor = Color.fromRGBO(154, 1, 45, 1);
  static final greenColor = Color.fromRGBO(11, 248, 6, 1);
  static final TYPE_VIDEO = 'video';
  static final TYPE_TEXT = 'text';
  static final ADMOB_APP_ID =
      'ca-app-pub-8342306822212092~2420832482'; //TODO: change this app ID with customers app ID

  //SQUARE PAYMENT CREDENTIALS
  String HOST_URL;
  static final LOCATION_ID = '29XHH9BH7BDGE';
  static final SQUARE_APP_ID = 'sandbox-sq0idb-zuC_5nfmmmoCdzUuwyaJ0w';
  static final AUTHORIZATION =
      'Bearer EAAAEPXhMMDm76hgAuDIeSupqmjqpAKyYUcbOvpIGN67LnoCRflsq4lnDiLDC1Qf';
  static final CONTENT_TYPE = 'application/json';
  static final ACCEPT = 'application/json';
  String IDEMPOTENCY_KEY;
  static final CURRENCY = 'USD';

  Constants() {
    HOST_URL = 'https://connect.squareup.com/v2/locations/$LOCATION_ID'
        '/transactions';
    if (Constants.SQUARE_APP_ID.startsWith('sandbox')) {
      HOST_URL =
          'https://connect.squareupsandbox.com/v2/locations/$LOCATION_ID/transactions';
    }
    IDEMPOTENCY_KEY = Uuid().v4();
  }
}
