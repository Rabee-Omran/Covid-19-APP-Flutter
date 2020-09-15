import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data_source.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {

  List countriesData;
  List items;

  fetchCountriesData() async {
    http.Response response = await http.get(
        'https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countriesData = json.decode(response.body);
      items = json.decode(response.body);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCountriesData();


  }
  void filterSearchResults(String query) {
    List dummySearchList = List();
    dummySearchList.addAll(countriesData);
    if(query.isNotEmpty) {
      List dummyListData = List();
      dummySearchList.forEach((item) {
        if(item['country'].toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        countriesData.clear();
        countriesData.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        countriesData.clear();
        countriesData.addAll(items);


      });
    }

  }
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حالة البلدان'),
      ),
      body: countriesData == null
          ? Center(

        child: CircularProgressIndicator(
        backgroundColor: primaryBlack,

      ),)
          :
      Column(


        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child:
            TextField(
textDirection: TextDirection.ltr,
             textAlignVertical: TextAlignVertical.center,
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: editingController,
              decoration:
              InputDecoration(
                  labelText: "بحث",
                  hintText: "بحث",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
            Expanded(
              child: ListView.builder(
              shrinkWrap: true,
              itemCount: countriesData == null ? 0 : countriesData.length,
              itemBuilder: (context, index) {
                return Container(

                  height: 130,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                      border: Border.all(color:primaryBlack),

                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color:primaryBlack,
                            offset: Offset(0,0),
                            blurRadius: 20
                        )
                      ]
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              countriesData[index]['country'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Image.network(
                              countriesData[index]['countryInfo']['flag'],
                              height: 50,
                              width: 60,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'الحالات المؤكَّدة : ' + countriesData[index]['cases'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              Text(
                                'الحالات النشطة : ' + countriesData[index]['active'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              Text('حالات الشفاء : ' + countriesData[index]['recovered'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              Text('حالات الوفاة : ' +countriesData[index]['deaths'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800]),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
        ),
            ),],
      )
    );
  }
}