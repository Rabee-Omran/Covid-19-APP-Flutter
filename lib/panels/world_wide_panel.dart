

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorldWidePanel extends StatelessWidget {

  final Map worldWide;

  const WorldWidePanel({Key key, this.worldWide}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(

        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5

        ),
        children: <Widget>[


          StatusPanel(
              title: 'الحالات المؤكَّدة',
              panelColor: Colors.red[100],
              textColor: Colors.red,
              count: worldWide['cases'].toString(),
              icona: 'img/w.png',

            ),

          StatusPanel(
            title: 'الحالات النشطة',
            panelColor: Colors.blue[100],
            textColor: Colors.blue[900],
            count: worldWide['active'].toString(),
            icona: 'img/infected.png',
          ),
          StatusPanel(
            title: 'حالات الشفاء',
            panelColor: Colors.green[100],
            textColor: Colors.green,
            count: worldWide['recovered'].toString(),
            icona: 'img/a.png',
          ),
          StatusPanel(
            title: 'حالات الوفاة',
            panelColor: Colors.grey[400],
            textColor: Colors.grey[900],
            count: worldWide['deaths'].toString(),
            icona:'img/dead.png',
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {

  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;
  final String icona;

  const StatusPanel({Key key, this.panelColor, this.textColor, this.title, this.count , this.icona}) : super(key: key);@override


  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Container(
      margin: EdgeInsets.all(10),
      height: 80,
      width: width / 2,
      color: panelColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center ,
        children: <Widget>[
          Text(title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: textColor
            ),
          ),
          Text(count,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: textColor
            ),

          ),
          Padding(padding: EdgeInsets.only(top: 4)),

          Image.asset(icona,height: 27, ),
        ],
      ),
    );
  }


}
