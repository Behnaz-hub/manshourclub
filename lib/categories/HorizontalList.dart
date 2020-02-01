import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:manshourclub/models/senfs.dart';
import 'package:http/http.dart' as http;


class HorizontalList extends StatelessWidget {
  List<Senf> asnaf;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Senf>>(
      future: _fetchJobs(),

      builder: (context, snapshot) {
        if (snapshot.hasData) {
          asnaf = snapshot.data;
          return  _jobsListView(asnaf);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },

    );

  }
  ListView _jobsListView(data) {
    return ListView.builder(
        itemCount: asnaf.length ,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {

          return
            Container(
                height: 100,
                child: Column(
                    children:[
                      Image.network(
                        'http://manshourclub.com/admin/images/asnaf/icons/'+data[index].icon,
                        width: 50,
                        height: 50,
                      ),
                      Text(
                          data[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                          ))
                    ]

                )
            );

        });
  }
}


Future<List<Senf>> _fetchJobs() async {

  final jobsListAPIUrl = 'https://manshourclub.com/API/Loans/AllSenf.php';
  final response = await http.get(jobsListAPIUrl);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((job) => new Senf.fromJson(job)).toList();
  } else {
    throw Exception('Failed to load jobs from API');
  }
}

ListTile _tile(String title, String icon) => ListTile(


  leading:
      Container(
        height: 100,
        child: Column(
          children:[
            Image.network(
              icon,
              width: 50,
              height: 50,
            ),
            Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                ))
          ]

        )
      )

);

