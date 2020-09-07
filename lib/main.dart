import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Interest Calculator App",
      home: SIForm(),
      theme: ThemeData(
          primaryColor: Colors.indigo,
          accentColor: Colors.indigoAccent,
          brightness: Brightness.light),
    ));

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return homepage();
  }
}

class homepage extends State<SIForm> {
  var curr = ["Rupees", "Dollar", "Pounds"];
  var defaultvalue = "Rupees";
  var displayresult = "";
  TextEditingController principleController = TextEditingController();
  TextEditingController RIController = TextEditingController();
  TextEditingController TermController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Container(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Simple Interest Calculator"),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                dollarimage(),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: TextFormField(
                    style: textStyle,
                    // ignore: missing_return
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter The Principle Amount';
                      }
                    },
                    keyboardType: TextInputType.number,
                    controller: principleController,
                    decoration: InputDecoration(
                        labelText: 'Principle',
                        hintText: 'Enter Principle e.g. 12000 ',
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                            color: Colors.yellowAccent, fontSize: 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: RIController,
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please Enter The Rate Of Interest';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Rate Of Interest',
                          hintText: 'In Percentage',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                              color: Colors.redAccent, fontSize: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)))),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          style: textStyle,
                          keyboardType: TextInputType.number,
                          controller: TermController,
                          // ignore: missing_return
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter Term';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Term',
                              hintText: 'Time in Years',
                              labelStyle: textStyle,
                              errorStyle: TextStyle(
                                  color: Colors.yellowAccent, fontSize: 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                      Container(
                        width: 25.0,
                      ),
                      Expanded(
                        child: DropdownButton<String>(
                          items: curr.map((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                          value: defaultvalue,
                          onChanged: (String newvalue) {
                            setState(() {
                              this.defaultvalue = newvalue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColor,
                          child: Text("Calculate",
                              textScaleFactor: 1.1, style: textStyle),
                          onPressed: () {
                            setState(() {
                              if (formKey.currentState.validate()) {
                                this.displayresult = calculateTotal();
                              }
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 12.0,
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text("Reset",
                              textScaleFactor: 1.1, style: textStyle),
                          onPressed: () {
                            setState(() {
                              reset();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      this.displayresult,
                      style: textStyle,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  String calculateTotal() {
    double principle = double.parse(principleController.text);
    double roi = double.parse(RIController.text);
    double term = double.parse(TermController.text);
    double total = principle + (roi * term * principle / 100);
    String result =
        "After $term years,Your Investment will be worth $total ${this.defaultvalue}";
    return result;
  }

  void reset() {
    principleController.text = '';
    RIController.text = '';
    TermController.text = '';
    displayresult = '';
    defaultvalue = 'Rupees';
  }
}

class dollarimage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetimage = AssetImage('images/image2.png');
    Image image = Image(
      image: assetimage,
      width: 700.0,
      height: 235.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.only(top: 13.0),
    );
  }
}
