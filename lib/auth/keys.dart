import 'package:document_summary_bot/auth/secrets.dart';


class Secret {
  final String apikey;

  Secret({this.apikey=""});

  factory Secret.fromJson(Map<String, dynamic>jsonMap){
    return Secret(apikey:jsonMap["api_key"]);
  }
}


class SecretLoader {
  final String secretName;

  SecretLoader({required this.secretName});

  Secret load() {
    final secret = Secret(apikey: secrets[secretName]);
    return secret;
  }
}
