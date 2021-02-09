import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        // color: Color(0xfff5f5f7),
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: "Search for a patient",
          contentPadding: EdgeInsets.all(15),
          border: InputBorder.none,
          // isDense: true,
        ),
      ),
    );
  }
}
