import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'bot_message_card.dart';
import 'model/bot_chat.dart';
import 'model/user_chat.dart';
import 'user_message_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _chatEditingController =
      TextEditingController(text: '');
  final List<dynamic> lstChat = [
    BotChat(
        message:
            '${DateFormat('EEEE HH:mm dd/MM/y', 'vi_VN').format(DateTime.now())}\nTôi có thể hỗ trợ gì cho bạn?'),
  ];
  late final GenerativeModel _model;
  late final ChatSession _chatSession;

  final ScrollController _scrollController = ScrollController();
  bool _enableSend = true;

  @override
  void initState() {
    _model = GenerativeModel(
        model: 'gemini-pro',
        apiKey: 'AIzaSyCgv9wY8YKYSjEfjM5mSvMopU5VStP1YAs',
        generationConfig: GenerationConfig());
    _chatSession = _model.startChat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff141414),
      body: Column(
        children: [
          Expanded(
            child: Container(
                color: const Color(0xff141414),
                child: ListView(
                  children: lstChat
                      .map((e) => e is UserChat
                          ? UserMessageCard(userChat: e)
                          : BotMessageCard(botChat: e))
                      .toList(),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _chatEditingController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(14),
                filled: true,
                fillColor: const Color(0xff212121),
                suffixIcon: GestureDetector(
                    onTap: () async {
                      if (_enableSend =
                          false || _chatEditingController.text.isEmpty) {
                        return;
                      }
                      _enableSend = false;
                      FocusScope.of(context).unfocus();
                      _sendMessage();
                    },
                    child: _enableSend
                        ? const Icon(Icons.send_rounded, color: Colors.white)
                        : const CupertinoActivityIndicator(
                            color: Colors.white,
                          )),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _sendMessage() async {
    lstChat.add(UserChat(message: _chatEditingController.text));
    String text = _chatEditingController.text;
    _chatEditingController.clear();
    setState(() {});
    var response = await _chatSession.sendMessage(Content.text(text));
    response;
    if (response.text == null) {
      lstChat.add(const BotChat(
          isError: true, message: 'Đã có lỗi xảy ra. Vui lòng thử lại sau!'));
    } else {
      lstChat.add(BotChat(message: response.text?.replaceAll('*', '') ?? ''));
    }
    setState(() {});

    _enableSend = true;
    if (_scrollController.position.pixels <
        _scrollController.position.maxScrollExtent) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }
}
