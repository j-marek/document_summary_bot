import 'dart:convert';
import 'dart:io';

import 'package:dart_openai/openai.dart';
import 'package:document_summary_bot/auth/keys.dart';
import 'package:http/http.dart' as http;


Future<String> summarize({
  required String inputText,
  required String type,
  required String style,
}) async {

  SecretLoader secretLoader = SecretLoader(secretPath: "assets/secrets.json");
  Secret secret = await secretLoader.load();

  OpenAI.apiKey = secret.apikey;
  OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
    model: "gpt-3.5-turbo",
    messages: [
      OpenAIChatCompletionChoiceMessageModel(
        content: "You are a helpful assistant. You will $type the following text. You will do it in a $style tone. You will not provide any commentary. - $inputText",
        role: OpenAIChatMessageRole.user,
      ),
    ],
  );

  return chatCompletion.choices.first.message.content;
}
