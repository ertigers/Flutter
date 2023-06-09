import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

import './dropdown_header.dart';

Widget buildCheckItem(BuildContext context, dynamic data, bool selected) {
  return Padding(
    padding: EdgeInsets.all(10.0),
    child: Row(
      children: <Widget>[
        Text(
          defaultGetItemLabel(data),
          style: selected
          ? TextStyle(
              fontSize: 14.0,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w400)
          : TextStyle(fontSize: 14.0),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: selected
            ? Icon(
                Icons.check,
                color: Theme.of(context).primaryColor,
              )
            : null,
          )
        ),
      ],
    )
  );
}
