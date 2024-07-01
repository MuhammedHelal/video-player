import 'package:flutter/material.dart';

class VideoDetailsScreen extends StatelessWidget {
  const VideoDetailsScreen({
    super.key, // required this.overlayDispose,
  });
  //final Function() overlayDispose;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Done'),
          ),
          const Center(
            child: Text(
              'Video details screen not finished yet',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  decorationStyle: TextDecorationStyle.double),
            ),
          ),
        ],
      ),
    );
  }
}
