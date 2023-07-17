import 'package:flutter/material.dart';
import 'package:whatchat/chats/presentation/pages/show_maps.dart';

class MessageUbication extends StatefulWidget {
  double latitude;
  double longitude;

  MessageUbication({Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  State<MessageUbication> createState() => _MessageTextState();
}

class _MessageTextState extends State<MessageUbication> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowMaps(
                  latitude: widget.latitude, longitude: widget.longitude),
            ),
          );
        },
        child: const SizedBox(
          width: 100,
          height: 100,
          child: Icon(
            Icons.location_on,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );
  }
}
