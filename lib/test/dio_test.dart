// ignore_for_file: use_key_in_widget_constructors

/*********************************************************************************
 * Author: Argost Ye
 * Time: 2/8/22
 **********************************************************************************/
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DioTestState();
  }
}

class _DioTestState extends State<DioTest> {
  Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("StaggerAnimation"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: FutureBuilder(
                future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Response response = snapshot.data;
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return Expanded(
                      child: ListView(
                        children: response.data
                            .map<Widget>((e) => ListTile(title: Text(e["full_name"]))).toList(),
                      ),
                    );
                  }

                  return CircularProgressIndicator();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
