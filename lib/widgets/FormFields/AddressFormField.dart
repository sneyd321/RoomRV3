

import 'package:flutter/material.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:notification_app/services/stream_socket.dart';
import 'package:notification_app/widgets/Cards/SuggestedAddressCard.dart';
import 'package:socket_io_client/socket_io_client.dart';




class AddressFormField extends StatefulWidget {
  final Function(BuildContext context, SuggestedAddress suggestedAddress, bool isTest)
      onSuggestedAddress;

  final StreamSocket streamSocket;
  final bool isTest;

  const AddressFormField(this.onSuggestedAddress, this.streamSocket, {Key? key, this.isTest=false})
      : super(key: key);

  @override
  State<AddressFormField> createState() => _AddressFormFieldState();
}

class _AddressFormFieldState extends State<AddressFormField> {
  final TextEditingController _textEditingController = TextEditingController();
  bool hasFailedToConnect = false;
  final int maxCharacterLength = 100;
  final IO.Socket socket = IO.io(
      'https://address-service-s5xgw6tidq-uc.a.run.app',
      OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect()
          .enableForceNew() // disable auto-connection
          .build());

  @override
  void initState() {
    super.initState();
    
    socket.connect();
      socket.onConnect((_) {

      });
  }

  @override
  void dispose() {
    super.dispose();
    socket.disconnect();
    socket.onDisconnect((_) {
      print("disconnect");
    });
    socket.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin:
              const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 0, top: 8),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _textEditingController,
            keyboardType: TextInputType.streetAddress,
            maxLines: 1,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              errorBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              prefixIcon: Icon(Icons.house),
              labelText: "Auto Complete Address",
            ),
            onSaved: (String? value) {},
            validator: (String? value) {
              if (hasFailedToConnect) {
                return "Service currently unavailable";
              }
            },
            onChanged: (value) {
              setState(() {
               
                if (value.length > 3) {
                  socket.emit('message', value);
                  socket.on('event', (data) {
                    widget.streamSocket.addResponse(data);
                  });
                  socket.onConnectError((data) {
                    hasFailedToConnect = true;
                    
                  });
                } else {
                  widget.streamSocket.addResponse([]);
                }
              });
            },
          ),
        ),
        StreamBuilder(
          stream: widget.streamSocket.getResponse,
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (!snapshot.hasData) {
              return const SizedBox.shrink();
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                if (snapshot.data == null) {
                  return const SizedBox.shrink();
                }
                return Container(
                    margin: const EdgeInsets.only(left: 8, right: 8),
                    child: SuggestedAddressCard(
                        SuggestedAddress.fromJson(snapshot.data![index]),
                        widget.onSuggestedAddress, isTest: widget.isTest,
                        ));
              },
            );
          },
        )
      ],
    );
  }
}
