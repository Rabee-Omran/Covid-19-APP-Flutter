import 'dart:convert';
import 'package:covid19fsy/pages/country_page.dart';
import 'package:covid19fsy/panels/info_panel.dart';
import 'package:covid19fsy/panels/most_effected_countries.dart';
import 'package:covid19fsy/panels/world_wide_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


import 'data_source.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map worldData;

  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countriesData;

  fetchCountriesData() async {
    http.Response response = await http.get(
        'https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countriesData = json.decode(response.body);
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchWorldWideData();
    fetchCountriesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('كوفيد-19'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 46,
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              color: Colors.orange[100],
              child: Text(
                  DataSource.quote,
                  style: TextStyle(
                      color: Colors.orange[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'على مستوى العالم',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => CountryPage() ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: primaryBlack,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'حالة البلدان',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            worldData == null ? Center(child: CircularProgressIndicator(
              backgroundColor: primaryBlack,
            ),) : WorldWidePanel(
              worldWide: worldData,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'الدول الأكثر تضرراً',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 10,),
            countriesData == null ? Container() : MostAffectedPanel(countryData: countriesData,),
            SizedBox(height:5,),
          InfoPanel(),
            SizedBox(height:10,),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Text('نحن معاً في هذا',
                    style: TextStyle(
                        color: primaryBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 4)),
                  Image.asset('img/h.png',width: 23,),
                ],
              ),
            ),
            SizedBox(height:40,),
          ],
        ),
      ),
      drawer: Drawer(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 200.0),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'img/x.png',
                    height: 160.0,
                    width: 160.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                  ),
                  Text(
                    'كوفيد - 19   ',
                    style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                  ),

                       Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[


                          Text(
                            'Developed By : Rabee Omran',
                            style: TextStyle(fontSize: 15.0, fontStyle: FontStyle.italic),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                          ),

                              GestureDetector(
                                onTap: () {
                                  launch('https://www.facebook.com/RabeeOmran2/');
                                },
                                child: Image.asset(
                                  'img/f.png',
                                  height: 30.0,
                                  width: 30.0,
                                ),
                              ),


                        ],

                  ),
                ],
    )),
          )));


  }
}



