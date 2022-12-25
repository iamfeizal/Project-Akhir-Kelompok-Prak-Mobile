// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/model/news_model.dart';

import 'package:url_launcher/url_launcher.dart';

// final url = 'https://flutter.dev';

class DetailBuku extends StatefulWidget {
  final Articles news;

  const DetailBuku({Key? key, required this.news}) : super(key: key);

  @override
  State<DetailBuku> createState() => _DetailBukuState();
}

class _DetailBukuState extends State<DetailBuku> {
  bool _hasBeenPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: _hasBeenPressed ? Colors.yellow : Colors.white,
      appBar: AppBar(
        title: Text("News"),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            height: (MediaQuery.of(context).size.height) / 3,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Image.network(
                    widget.news.urlToImage!,
                    width: 200,
                    height: 150,
                  ),
                );
              },
              itemCount: widget.news.urlToImage!.length,
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            // alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                boldText(widget.news.title!),
                SizedBox(
                  height: 5,
                ),
                // mediumText(
                //   "Rp. " + widget.news.price,
                // ),
                // SizedBox(
                //   height: 5,
                // ),
                // mediumText("Discount " + widget.news.discount),
                // SizedBox(height: 10),
                // mediumText("Stock :" + widget.news.stock),
                // SizedBox(
                //   height: 10,
                // ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, //Center Column contents vertically,
                    crossAxisAlignment: CrossAxisAlignment
                        .center, //Center Column contents horizontally,
                    children: [
                      Text(widget.news.publishedAt!.substring(0, 10)),
                      SizedBox(
                        width: 40,
                      ),
                      ElevatedButton.icon(
                        onPressed: () =>
                            setState(() => _hasBeenPressed = !_hasBeenPressed),
                        icon: _hasBeenPressed
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_border),
                        label: Text("Favorite"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
                  child: mediumText("" + widget.news.content!),
                ),
                SizedBox(
                  height: 5,
                ),
                TextButton(
                  child: Text("Go To Article"),
                  onPressed: () {
                    _launchURL(widget.news.url!);
                  },
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget boldText(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600, color: Colors.blue),
    );
  }

  Widget mediumText(String text) {
    return Text(text,
        style: TextStyle(fontSize: 15, color: Colors.black87),
        textAlign: TextAlign.start);
  }
}

Future<void> _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
