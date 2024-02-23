import 'package:flutter/material.dart';
import 'models/conversation.dart';

class MessagingPage extends StatelessWidget {
  final List<Conversation> conversations = [
    Conversation(
      id: 1,
      title: 'John Doe',
      lastMessage: 'Salut, comment ça va ?',
      messages: [
        Message(content: 'Salut, comment ça va ?', isMe: true),
        Message(content: 'Ça va bien, merci ! Et toi ?', isMe: false),
      ],
    ),
    Conversation(
      id: 2,
      title: 'Jane Doe',
      lastMessage: 'Ça va bien, merci ! Et toi ?',
      messages: [
        Message(content: 'Ça va bien, merci ! Et toi ?', isMe: false),
        Message(content: 'Très bien, merci !', isMe: true),
      ],
    ),
    // Ajoutez ici plus de conversations
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messagerie'),
      ),
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final conversation = conversations[index];
          return ConversationCard(
            conversation: conversation,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(conversation: conversation),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ConversationCard extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback onTap;

  const ConversationCard({
    required this.conversation,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green,
      child: ListTile(
        title: Text(
          conversation.title,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          conversation.lastMessage,
          style: TextStyle(color: Colors.white),
        ),
        onTap: onTap,
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  final Conversation conversation;

  const ChatPage({
    required this.conversation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(conversation.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: conversation.messages.length,
              itemBuilder: (context, index) {
                final message = conversation.messages[index];
                return MessageBubble(
                  message: message.content,
                  isMe: message.isMe,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Votre message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const MessageBubble({
    required this.message,
    required this.isMe,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: isMe ? Colors.green : Colors.grey.shade300,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
            ),
          ),
          child: Text(
            message,
            style: TextStyle(color: isMe ? Colors.white : Colors.black),
          ),
        ),
      ],
    );
  }
}
