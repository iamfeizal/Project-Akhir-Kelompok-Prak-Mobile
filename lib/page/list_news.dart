import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/base_network.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/news_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'detail_page.dart';

class ListNews extends StatefulWidget {
  const ListNews({Key? key}) : super(key: key);
  @override
  _ListNewsState createState() => _ListNewsState();
}

class _ListNewsState extends State<ListNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: _buildDetailCountriesBody(),
    );
  }

  Widget _buildDetailCountriesBody() {
    return Container(
      child: FutureBuilder(
        future: BaseNetwork.get(),
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            NewsModel countriesModel = NewsModel.fromJson(snapshot.data);
            return _buildSuccessSection(countriesModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildEmptySection() {
    return Text("Empty");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(NewsModel data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        //     maxCrossAxisExtent: 205,
        //     childAspectRatio: 3 / 2,
        //     crossAxisSpacing: 20,
        //     mainAxisSpacing: 20),
        itemCount: data.articles?.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            // width: 300,
            // height: 110,
            child: Column(
              children: [
                InkWell(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailBuku(
                                    news: data.articles![index],
                                  )));
                      // _launchURL("${data.articles![index].url}");
                    }),
                    child: Card(
                      child: Row(
                        children: [
                          Image.network(
                            "${data.articles![index].urlToImage}",
                            width: 200,
                            height: 150,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${data.articles![index].title}",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${data.articles![index].source!.name}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${data.articles![index].publishedAt?.substring(0, 10)}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w100,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                // Center(
                //     child: Text("${data.countries?[index].iso3}",
                //         style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          );
          // _buildItemCountries("${data.countries?[index].name}");
        },
      ),
    );
  }

  Widget _buildItemCountries(String value) {
    return Text(value);
  }
}

// Future<void> _launchURL(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
