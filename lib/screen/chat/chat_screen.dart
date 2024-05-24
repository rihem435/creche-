import 'package:creche/core/networking/app_api.dart';
import 'package:creche/core/storage/info_storage.dart';
import 'package:creche/models/all_messages_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  final String? title;
  const ChatScreen({super.key, this.title});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  bool? isSentByMe;
  void _handleSendPressed() {
    if (_controller.text.isEmpty) {
      return;
    } else {
      sendMessage(_controller.text, InfoStorage.readId().toString(),
          InfoStorage.readIdParent().toString());
    }

    setState(() {
      getAllMessages();
    });

    _controller.clear();
  }

  //late IO.Socket _socket;
  String websocketAddress = 'http://localhost:3001';
  final IO.Socket _socket = IO.io(
    'http://localhost:3001',
    // <String, dynamic>{
    //   'transports': kIsWeb ? ['polling'] : ['websocket'],
    //   'autoConnect': false,
    //   'extraHeaders': {"authorization": "Bearer ${AppStorage.readToken()}"}
    // },
  );
  void connect() async {
    try {
      print('--------------------connect--------------------------');

      _socket.onConnect(
        (data) {
          print(
              "++++++++++++++++++++++++++testconnect--------------------------${_socket.connected}");
          print("connect socket ");
        },
      );
      _socket.on('message', (_) {
        setState(
          () {
            getAllMessages();
          },
        );
      });
      _socket.onError(
        (data) => "Error connect================>$data",
      );
      // _socket.onDisconnect(
      //   (data) => print('999999999disconnect===========$data'),
      // );
    } catch (error) {
      print(
          '---------------------------Error connecting to WebSocket server: $error');
    }
  }

  void sendMessage(String t, String senderId, String reciverId) {
    _socket.emit(
        'message', {"text": t, "senderId": senderId, "receiverId": reciverId});
  }

  final dio = Dio();
  // ignore: use_function_type_syntax_for_parameters

  AllMessagesModel? allMessagesModel;
//--------------------------------------------------------
  Future<AllMessagesModel?> getAllMessages() async {
    print(
        "all message--------------------------------------- ${AppApi.listMessagesUrl}");
    try {
      Response response = await dio.get(
          "${AppApi.listMessagesUrl}${InfoStorage.readId()}/${InfoStorage.readIdParent()}");

      print('value ===================> $response');
      if (response.statusCode == 200) {
        allMessagesModel = AllMessagesModel.fromJson(response.data);

        return allMessagesModel;
      }
      return null;
    } catch (error) {
      print('error===========>$error');
    }
    return null;
  }

//--------------------------------------------------------
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    connect();
    //getAllMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[50],
          title: Text(
            widget.title!,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              //   setState(() {

              //InfoStorage.removeId();
              Navigator.pop(context);
              //  });
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FutureBuilder(
                future: getAllMessages(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (allMessagesModel!.data!.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: allMessagesModel!.data!.length,
                          itemBuilder: (context, index) {
                            //   final message = _messages[index];
                            return MessageWidget(
                                message: Message(
                              text: allMessagesModel!.data![index].text!,
                              isSentByMe:
                                  allMessagesModel!.data![index].senderId ==
                                          InfoStorage.readId()
                                      ? true
                                      : false,
                            ));
                          },
                        ),
                      );
                    } else if (allMessagesModel!.data!.isEmpty) {
                      print("error-------------------");
                      return const Center(
                        child: Card(
                          child: Text(
                              "Ce chat ne contient aucun message pour le moment."),
                        ),
                      );
                    }
                    // we have the data, do stuff here
                  }
                  return const SizedBox.shrink();
                },
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Enter your message...',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  12,
                                ),
                              ),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(
                                  255,
                                  240,
                                  195,
                                  178,
                                ),
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  12,
                                ),
                              ),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(
                                  255,
                                  240,
                                  195,
                                  178,
                                ),
                              )),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Color.fromARGB(
                          255,
                          240,
                          195,
                          178,
                        ),
                      ),
                      onPressed: _handleSendPressed,
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

class Message {
  final String text;
  final bool isSentByMe;

  Message({
    required this.text,
    required this.isSentByMe,
  });
}

class MessageWidget extends StatelessWidget {
  final Message message;

  const MessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      alignment:
          message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: message.isSentByMe
              ? const Color.fromARGB(
                  255,
                  240,
                  195,
                  178,
                )
              : Colors.grey[300],
          borderRadius: BorderRadius.only(
              bottomLeft: message.isSentByMe
                  ? const Radius.circular(12)
                  : const Radius.circular(-00),
              bottomRight: message.isSentByMe
                  ? const Radius.circular(-200)
                  : const Radius.circular(12),
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12)),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isSentByMe ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
