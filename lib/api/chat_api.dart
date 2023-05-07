import 'package:chatgpt_client/models/chat_message.dart';
import 'package:chatgpt_client/secrets.dart';
import 'package:dart_openai/openai.dart';

// You are an assistant that speaks like Shakespeare.

class ChatApi {
  static const _model = 'gpt-3.5-turbo';
  static var isValue = true;
  ChatApi() {
    OpenAI.apiKey = openAiApiKey;
   // OpenAI.organization = openAiOrg;
  }

  Future<String> completeChat(List<ChatMessage> messages) async {

    final chatCompletion = await OpenAI.instance.chat.create(
      model: _model,
      messages: messages
          .map((e) => OpenAIChatCompletionChoiceMessageModel(
              role: e.isUserMessage ? OpenAIChatMessageRole.user : OpenAIChatMessageRole.assistant,
              content: isValue ? "You are an assistant that speaks like Shakespeare." : e.content,
              ))
          .toList(),
    );
    isValue = false;
    return chatCompletion.choices.first.message.content;
  }
}
