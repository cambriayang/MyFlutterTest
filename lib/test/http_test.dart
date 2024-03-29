// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace

/*********************************************************************************
 * Author: Argost Ye
 * Time: 2/8/22
 **********************************************************************************/
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HttpTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HttpTestRouteState();
  }
}

class _HttpTestRouteState extends State<HttpTestRoute> {
  bool _loading = false;
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$runtimeType"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: _loading ? null : request, child: Text("获取百度首页")),
            Container(
              width: MediaQuery.of(context).size.width - 50.0,
              child: Text(_text.replaceAll(r"\s", "")),
            )
          ],
        ),
      ),
    );
  }

  request() async {
    setState(() {
      _loading = true;
      _text = "正在请求...";
    });

    try {
      HttpClient httpClient = HttpClient();
      HttpClientRequest request =
          await httpClient.getUrl(Uri.parse("https://www.baidu.com"));
      request.headers.add("user-agent",
          "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
      HttpClientResponse response = await request.close();
      _text = await response.transform(utf8.decoder).join();
      if (kDebugMode) {
        print(response.headers);
      }
      httpClient.close();
    } catch (e) {
      _text = "请求失败：$e";
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}
