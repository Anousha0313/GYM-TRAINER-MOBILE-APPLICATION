import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newproject/TrainerPage.dart';
import 'package:newproject/WelcomePage.dart';
class ChatWithTrainerPage extends StatefulWidget {
  final Map<String, String> trainer;

  const ChatWithTrainerPage({Key? key, required this.trainer}) : super(key: key);

  @override
  State<ChatWithTrainerPage> createState() => _ChatWithTrainerPageState();
}

class _ChatWithTrainerPageState extends State<ChatWithTrainerPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;

  static const List<String> _emojis = ['💪', '🔥', '😊', '👍', '🏋‍♂', '🥳', '🙌'];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        'sender': 'you',
        'text': text,
        'time': DateTime.now(),
      });
      _controller.clear();
      _isTyping = true;
    });
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _messages.add({
          'sender': 'trainer',
          'text': _generateAIReply(text),
          'time': DateTime.now(),
        });
        _isTyping = false;
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 60,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _generateAIReply(String userMessage) {
    // Simulated AI replies based on simple keywords
    final lower = userMessage.toLowerCase();
    if (lower.contains('tired')) return "Keep pushing! Rest is important too 💤";
    if (lower.contains('hi') || lower.contains('hello')) return "Hey! Ready to crush today's workout? 💪";
    if (lower.contains('how are you')) return "I'm great, thanks! Let's get stronger together! 🚀";
    return "Great job! Let's keep up the momentum 💪";
  }

  void _insertEmoji(String emoji) {
    _controller.text += emoji;
    _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
  }

  String _formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFD700), Color(0xFF8E2DE2)], // Yellow to Purple
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar style row
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Chat with ${widget.trainer['trainerName']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white30, height: 1),

              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length + (_isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (_isTyping && index == _messages.length) {
                      // Typing indicator
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Text(
                            "Trainer is typing...",
                            style: TextStyle(color: Colors.white70,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      );
                    }

                    final message = _messages[index];
                    final isMe = message['sender'] == 'you';

                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment
                          .centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        constraints: BoxConstraints(maxWidth: MediaQuery
                            .of(context)
                            .size
                            .width * 0.7),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.white : Colors.deepPurpleAccent
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: Radius.circular(isMe ? 16 : 0),
                            bottomRight: Radius.circular(isMe ? 0 : 16),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              message['text'],
                              style: TextStyle(
                                color: isMe ? Colors.black87 : Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _formatTime(message['time']),
                              style: TextStyle(
                                color: (isMe ? Colors.black45 : Colors.white54),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Emoji picker
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                color: Colors.white.withOpacity(0.1),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _emojis.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final emoji = _emojis[index];
                    return GestureDetector(
                      onTap: () => _insertEmoji(emoji),
                      child: Text(
                        emoji,
                        style: const TextStyle(fontSize: 28),
                      ),
                    );
                  },
                ),
              ),

              // Input bar
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                color: Colors.white.withOpacity(0.1),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Type your message...',
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                        ),
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}