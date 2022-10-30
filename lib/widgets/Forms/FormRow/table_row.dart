


import 'package:flutter/material.dart';

class TablePair extends StatelessWidget {

  final String name;
  final String value;

  const TablePair({Key? key, required this.name, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4, left: 8, right: 8, bottom: 4),
      child: Row(
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Flexible(child: Text(value, maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,),
          ),
        ],
      ),
    );
  }


}