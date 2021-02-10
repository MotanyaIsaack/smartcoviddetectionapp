import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_care/helper/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ViewPredictions extends StatefulWidget {
  @override
  _ViewPredictionsState createState() => _ViewPredictionsState();
}

class _ViewPredictionsState extends State<ViewPredictions> {
  bool _loading = false;
  List<Map<String, String>> predicted = [];
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    setState(() {
      _loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final id = await prefs.getInt("id");
    final data = {"user_id": id};
    http.Response res = await Network().authData(data, 'get_predictions');
    final responses = json.decode(res.body) as List<dynamic>;
    responses.forEach((value) {
      predicted.add({
        "prediction": value["prediction"],
        "prediction_time": value["prediction_time"]
      });
    });

    setState(() {
      _loading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(predicted);
    return Scaffold(
      appBar: AppBar(title: Text('View Predictions')),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : predicted.isEmpty
              ? Center(
                  child: Text('No predictions at this time'),
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.separated(
                    separatorBuilder: (ctx, i) => SizedBox(height: 20),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(20),
                    itemBuilder: (ctx, i) => Card(
                      elevation: 8,
                      child: ListTile(
                        leading: Icon(
                          Icons.science,
                          color: Theme.of(context).primaryColor,
                        ),
                        isThreeLine: true,
                        title:
                            Text('Prediction: ${predicted[i]["prediction"]}'),
                        subtitle:
                            Text('Date: ${predicted[i]["prediction_time"]}'),
                        enabled: true,
                      ),
                    ),
                    itemCount: predicted.length,
                  ),
                ),
    );
  }
}
