import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Cost App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TripCost(),
    );
  }
}

class TripCost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TripCostState();
}

class TripCostState extends State<TripCost> {
  String result = "";
  final _currencies = ['Pounds', 'Euro', 'Dollars'];
  String _currency = "Pounds";
  TextEditingController distanceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Cost Calculator'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: TextField(
                controller: distanceController,
                decoration: InputDecoration(
                    hintText: "e.g. 123",
                    labelText: "Distance",
                    labelStyle: labelStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: TextField(
                controller: avgController,
                decoration: InputDecoration(
                    hintText: "e.g. 13",
                    labelText: "Distance per Unit",
                    labelStyle: labelStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Row(children: <Widget>[
                  Expanded(
                      child: TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                      hintText: "e.g. 1.56",
                      labelText: "Price",
                      labelStyle: labelStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    keyboardType: TextInputType.number,
                  )),
                  Container(
                    width: 25,
                  ),
                  Expanded(
                      child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value));
                          }).toList(),
                          value: _currency,
                          onChanged: (String value) {
                            onDropDownChanged(value);
                          }))
                ])),
            Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        padding: EdgeInsets.all(10.0),
                        textColor: Theme.of(context).primaryColorLight,
                        onPressed: () {
                          setState(() {
                            result = calculate();
                          });
                        },
                        child: Text(
                          'Calculate',
                          textScaleFactor: 1.5,
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        padding: EdgeInsets.all(10.0),
                        textColor: Theme.of(context).primaryColorDark,
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                        child: Text(
                          'Reset',
                          textScaleFactor: 1.5,
                        ),
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(result),
            )
          ],
        ),
      ),
    );
  }

  onDropDownChanged(String value) {
    setState(() {
      this._currency = value;
    });
  }

  String calculate() {
    double distance = double.parse(distanceController.text);
    double fuelCost = double.parse(priceController.text);
    double consumption = double.parse(avgController.text);
    double totalCost = distance / consumption * fuelCost;
    String result = "The total cost of your trip is " +
        totalCost.toStringAsFixed(2) +
        " " +
        _currency;
    return result;
  }

  void _reset() {
    distanceController.text = "";
    priceController.text = "";
    avgController.text = "";
    result = "";
  }
}
