import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;


class Secret {
  final String apikey;

  Secret({this.apikey=""});

  factory Secret.fromJson(Map<String, dynamic>jsonMap){
    return Secret(apikey:jsonMap["open_ai"]);
  }
}


class SecretLoader {
  final String secretPath;

  SecretLoader({required this.secretPath});
  Future<Secret> load() {
    return rootBundle.loadStructuredData<Secret>(secretPath,
            (jsonStr) async {
          final secret = Secret.fromJson(json.decode(jsonStr));
          return secret;
        });
  }
}
