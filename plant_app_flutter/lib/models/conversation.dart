
class Conversation {
  final int id;
  final String title;
  final String lastMessage;
  final List<Message> messages;

  Conversation({
    required this.id,
    required this.title,
    required this.lastMessage,
    required this.messages,
  });
}

class Message {
  final String content;
  final bool isMe;

  Message({
    required this.content,
    required this.isMe,
  });
}