import 'package:flutter/material.dart';



import '../data_source.dart';

class FAQPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('أسئلة شائعة'),
        ),
        body: ListView.builder(
            itemCount: DataSource.questionAnswers.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
               leading: Directionality(textDirection: TextDirection.ltr,
                 child: Icon(Icons.help_outline,),),
                title: Text(
                  DataSource.questionAnswers[index]['question'],
                  style: TextStyle(fontWeight: FontWeight.bold,),
                ),
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(DataSource.questionAnswers[index]['answer'])
                  ),
              Padding(
              padding: const EdgeInsets.all(12.0),)
                ],
              );
            }
        )
    );
  }
}