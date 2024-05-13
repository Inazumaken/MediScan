import 'package:flutter/material.dart';

class BottomSheetWidget extends StatefulWidget {
  final String title;
  final Function(String) onSelected;

  BottomSheetWidget({required this.title, required this.onSelected});

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          ListTile(
            title: Text(widget.title),
            trailing: Icon(Icons.arrow_drop_down),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Divider(),
          ListTile(
            title: Text('Description'),
            onTap: () {
              widget.onSelected('Description');
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text('Usage'),
            onTap: () {
              widget.onSelected('Usage');
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}