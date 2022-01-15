import 'package:flutter/material.dart';
import 'package:dcdg/dcdg.dart';
class Nutrition extends StatefulWidget {
  @override
  _DataTableExample createState() => _DataTableExample();
}

class _DataTableExample extends State<Nutrition> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

          body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/img/best.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(children: <Widget>[

             Center(
                    child: Column(
                      children: [
                        Text(
                          'Nutritions-Chart ',
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Ages 14 to 18: Daily guidelines for girls',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),


              DataTable(
                columns: [
                  DataColumn(label: Text(
                      'Nutrients',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                  )),
                  DataColumn(label: Text(
                      'Level',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                  )),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('Calories')),
                    DataCell(Text('1800-2400 depending on growth and activity level')),

                  ]),
                  DataRow(cells: [
                    DataCell(Text('Protein')),
                    DataCell(Text('5-6.5 ounces')),

                  ]),
                  DataRow(cells: [
                    DataCell(Text('Fruits')),
                    DataCell(Text('1.5-2 cups')),

                  ]),
                  DataRow(cells: [
                    DataCell(Text('Vegetables')),
                    DataCell(Text('2.5-3 cups')),

                  ]),
                  DataRow(cells: [
                    DataCell(Text('Grains')),
                    DataCell(Text('6-8 ounces')),

                  ]),
                  DataRow(cells: [
                    DataCell(Text('Dairy')),
                    DataCell(Text('3 cups')),

                  ]),

                ],
              ),
            ]),
          )
    ),

    );
  }
}