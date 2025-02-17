import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  final String senderUid;
  final String receiverUid;
  final String senderDisplayName;
  final String recieverDisplayName;

  ChatScreen(
      {required this.senderUid,
      required this.receiverUid,
      required this.senderDisplayName,
      required this.recieverDisplayName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final CollectionReference _messagesCollection =
      FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff7a5050),
        title: Text(widget.recieverDisplayName),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _messagesCollection
                  .where('senderUid', isEqualTo: widget.receiverUid)
                  .where('receiverUid', isEqualTo: widget.senderUid)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                List<QueryDocumentSnapshot> messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(messages[index]['message']),
                      subtitle: Text(messages[index]['senderDisplayName']),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter a message...',
                    ),
                  ),
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xff7a5050),
                  ),
                  onPressed: () {
                    _sendMessage();
                  },
                  child: Text('Envoyer'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    String message = _messageController.text.trim();
    if (message.isNotEmpty) {
      _messagesCollection.add({
        'senderUid': widget.senderUid,
        'receiverUid': widget.receiverUid,
        'senderDisplayName': widget.senderDisplayName,
        'recieverDisplayName': widget.recieverDisplayName,
        'message': message,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });

      _messageController.clear();
    }
  }
}
