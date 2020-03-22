import 'package:flutter/material.dart';

void main() => runApp(StatefulApp());

class StatefulApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Hello gato",
        theme: new ThemeData(primarySwatch: Colors.blue),
        home: FuelForm());
  }
}

class HelloYou extends StatefulWidget {
  @override
  _HelloYouState createState() => _HelloYouState();
}

class _HelloYouState extends State<HelloYou> {
  String name = "";
  final _coloresDeGatito = ["Naranja", "Pinto", "Pelusa"];
  String _currentColorGato = "Naranja";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello gato"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration:
                  InputDecoration(hintText: "Inserte el nombre de un gatito"),
              onChanged: (String string) {
                setState(() {
                  name = string;
                });
              },
            ),
            Text("Gatito " + name + "!"),
            DropdownButton<String>(
              items: _coloresDeGatito
                  .map((String value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              value: _currentColorGato,
              onChanged: (String value) {
                _onDropDownChanged(value);
              },
            ),
          ],
        ),
      ),
    );
  }

  _onDropDownChanged(String value) {
    setState(() {
      this._currentColorGato = value;
    });
  }
}

class FuelForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  TextEditingController distanceController = TextEditingController();
  TextEditingController promedioController = TextEditingController();
  TextEditingController precioController = TextEditingController();

  String result = "";
  final _monedas = ["Pesos", "Dolares", "Euro"];
  final double _formDistance = 5.0;
  String _currentMoneda = "Pesos";

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBar(
        title: Text("Gasolina calculator"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(top: _formDistance, bottom: _formDistance),
              child: TextField(
                controller: distanceController,
                decoration: InputDecoration(
                    hintText: "ej 1234",
                    labelStyle: textStyle,
                    labelText: "Distancia",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: _formDistance, bottom: _formDistance),
              child: TextField(
                controller: promedioController,
                decoration: InputDecoration(
                    hintText: "ej 17",
                    labelStyle: textStyle,
                    labelText: "Distancia por unidad",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: _formDistance, bottom: _formDistance),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: precioController,
                      decoration: InputDecoration(
                          hintText: "ej 17.50",
                          labelStyle: textStyle,
                          labelText: "Precio",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    width: _formDistance * 5,
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      items: _monedas
                          .map((String value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (String value) {
                        setState(() {
                          _currentMoneda = value;
                        });
                      },
                      value: _currentMoneda,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    elevation: 15.0,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.monetization_on),
                        Text(
                          "Calculate",
                          textScaleFactor: 1.5,
                        ),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        result = _calcular();
                      });
                    },
                  ),
                ),
                Container(width: _formDistance *5,),
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).buttonColor,
                    textColor: Theme.of(context).primaryColorDark,
                    elevation: 15.0,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.remove_circle),
                        Text(
                          "Reset",
                          textScaleFactor: 1.5,
                        ),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        _reset();
                      });
                    },
                  ),
                ),
              ],
            ),
            Text(result),
          ],
        ),
      ),
    );
  }

  String _calcular() {
    num _distancia = num.parse(distanceController.text);
    num _promedio = num.parse(promedioController.text);
    num _precio = num.parse(precioController.text);
    num _resultado = _distancia / _promedio * _precio;

    return "Costo total del viaje es " +
        _resultado.toStringAsFixed(2) +
        " " +
        _currentMoneda;
  }

  void _reset() {
    distanceController.text = "";
    promedioController.text = "";
    precioController.text = "";
    setState(() {      
      result = "";
    });
  }
}
