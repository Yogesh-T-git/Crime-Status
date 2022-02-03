import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final items = ['Basically Law & Order situation','Crime Status of a location','B-Solution gives business','information such as:','JOBS','HIRING','About RECRUIT PROCESS','EQUIPMENT Sales','etc'];
  String value;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('FAQs'), centerTitle: true),
    body: Center(
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 4),
        ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
        value: value,
        iconSize: 36,
        items: items.map(buildMenuItem).toList(),
        onChanged: (value) => setState(() => this.value = value),
      ))
    )
    ));
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
    )
  );

}