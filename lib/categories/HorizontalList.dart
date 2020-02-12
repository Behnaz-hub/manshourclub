import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:manshourclub/models/senfs.dart';
import 'package:http/http.dart' as http;
import 'package:manshourclub/styles/loading.dart';
import 'package:manshourclub/styles/theme.dart' as theme;
import 'package:manshourclub/styles/constants.dart' as Constants;
import 'Providers.dart';


class HorizontalList extends StatelessWidget {

  List<Senf> asnaf;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Senf>>(
      future: fetchasnaf(),

      builder: (context, snapshot) {
        if (snapshot.hasData) {
          asnaf = snapshot.data;
          return  senflistview(asnaf);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return new Loading();
      },

    );

  }
  ListView senflistview(data) {
    return ListView.builder(
        itemCount: asnaf.length ,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {

          return
            Container(

                height: 100,
                width: MediaQuery.of(context).size.width*.24,
                decoration: BoxDecoration(
                    border: Border.all(color: theme.MYColors.productBackGround),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                ),

                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(2.0),
                child: GestureDetector(
                  onTap: (){
                    print(ListView);
                    var route = new MaterialPageRoute(
                        builder: (BuildContext context) => new Providers(
                            aid  :data[index].aid

                        ));
                    Navigator.of(context).push(route);
                  },
                  child:  Column(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Image.network(
                          Constants.asnaficon+data[index].icon,
                          width: 50,
                          height: 50,
                        ),
                        AutoSizeText(
                          data[index].name,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IRASans'
                          ),
                          maxLines: 1,
                          maxFontSize: 14,
                          minFontSize: 10,
                        )
                      ]

                  ),
                )

            );

        });
  }
}


Future<List<Senf>> fetchasnaf() async {

  final ListAPIUrl = '${Constants.asnafapi}AllSenf.php';
  final response = await http.get(ListAPIUrl);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((senf) => new Senf.fromJson(senf)).toList();
  } else {
    throw Exception('Failed to load data from API');
  }
}


