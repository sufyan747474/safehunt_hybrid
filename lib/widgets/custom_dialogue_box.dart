import 'package:flutter/material.dart';

class DropDownButtonPage extends StatefulWidget {
  @override
  _DropDownButtonState createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButtonPage> {
  var _value = "1";

  DropdownButton _normalDown() => DropdownButton<String>(
        items: [
          DropdownMenuItem<String>(
            value: "1",
            child: Text(
              "First",
            ),
          ),
          DropdownMenuItem<String>(
            value: "2",
            child: Text(
              "Second",
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _value = value!;
          });
        },
        value: _value,
      );

  DropdownButton _itemDown() => DropdownButton<String>(
        items: [
          DropdownMenuItem(
            value: "1",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.build),
                SizedBox(width: 10),
                Text(
                  "build",
                ),
              ],
            ),
          ),
          DropdownMenuItem(
            value: "2",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.settings),
                SizedBox(width: 10),
                Text(
                  "Setting",
                ),
              ],
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _value = value!;
          });
        },
        value: _value,
        isExpanded: true,
      );

  DropdownButton _hintDown() => DropdownButton<String>(
        items: [
          DropdownMenuItem<String>(
            value: "1",
            child: Text(
              "First",
            ),
          ),
          DropdownMenuItem<String>(
            value: "2",
            child: Text(
              "Second",
            ),
          ),
        ],
        onChanged: (value) {
          print("value: $value");
        },
        hint: Text(
          "Please select the number!",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );

  DropdownButton _hint2Down() => DropdownButton<String>(
        items: null,
        onChanged: null,
        disabledHint: Text("You can't select anything."),
      );

  DropdownButton _normal2Down() => DropdownButton<String>(
        items: [
          DropdownMenuItem<String>(
            value: "1",
            child: Text(
              "First",
            ),
          ),
          DropdownMenuItem<String>(
            value: "2",
            child: Text(
              "Second",
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _value = value!;
          });
        },
        value: _value,
        elevation: 2,
        style: TextStyle(color: Colors.purple, fontSize: 30),
        isDense: true,
        iconSize: 40.0,
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          //our code.
          Container(
            color: Colors.red,
            child: _normalDown(),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.blue,
            child: _itemDown(),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.yellow,
            child: _hintDown(),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.green,
            child: _hint2Down(),
          ),
          SizedBox(height: 10),
          Container(
            color: Colors.red,
            alignment: Alignment.topRight,
            child: _normal2Down(),
          ),
          SizedBox(height: 600)
        ],
      ),
    );
  }
}
