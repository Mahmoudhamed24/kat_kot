import '../utils/exports.dart';
import 'package:http/http.dart' as http;
// ignore: unnecessary_import
import 'dart:convert';

class ApiClass {
  Future<String> mainApi(String prompt, ScrollController controller) async {
    try {
      final response = await http.post(
          Uri.parse("https://api.openai.com/v1/chat/completions"),
          headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer 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"
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                "role": "assistant",
                "content":
                    "is this asking you to generate or create or make an AI image, drawing, picture, photograph, painting or art? : $prompt. if yes then reply simply yes else no in lowercase"
              }
            ]
          }));

      if (response.statusCode == 200) {
        //prompt response
        final String content =
            jsonDecode(response.body)["choices"][0]["message"]["content"];
        content.trim();
        return content;
      }
      return "Something went wrong";
    } catch (e) {
      return e.toString();
    }
  }

  //chat gpt api for basic text prompt
  Future<String> chatGptApi(String prompt, ScrollController controller) async {
    try {
      final response = await http.post(
          Uri.parse("https://api.openai.com/v1/chat/completions"),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "Accept-Charset": "utf-8",
            "Authorization":
                "Bearer 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"
          },
          body: json.encode({
            "model": "gpt-3.5-turbo",
            "messages": [
              {"role": "assistant", "content": prompt}
            ]
          }));
      if (response.statusCode == 200) {
        final String content =
            jsonDecode(response.body)["choices"][0]["message"]["content"];
        content.trim();
        return content;
      }
      return "Something went wrong";
    } catch (e) {
      return e.toString();
    }
  }

  //Dall-E API for image generation
  Future<String> imageGenerationApi(
      String prompt, ScrollController controller) async {
    try {
      final response = await http.post(
          Uri.parse("https://api.openai.com/v1/images/generations"),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "Accept-Charset": "utf-8",
            "Authorization":
                "Bearer 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"
          },
          body: json.encode({"prompt": prompt, "n": 1, "size": "1024x1024"}));
      if (response.statusCode == 200) {
        final String content = jsonDecode(response.body)["data"][0]["url"];
        content.trim();
        return content;
      }
      return "Something went wrong";
    } catch (e) {
      return e.toString();
    }
  }
}
