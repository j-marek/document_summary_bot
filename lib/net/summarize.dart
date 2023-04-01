Future<String> summarize({
  required String inputText,
  required String type,
  required String style,
}) async {
  await Future.delayed(const Duration(seconds: 3));
  return "hello world";
}
