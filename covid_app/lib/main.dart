import 'package:covid_app/Services/stateService.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(accentColor: Colors.amber),
      title: 'Co-Help',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List> _data;
  Future<List> _district;
  int _selectindex = 0;
  String _displayState = "Select State";
  String _displayDistrict = "Select District";
  void initState() {
    super.initState();
    _data = StateManager().getState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Covid Tracker"),
        ),
        body: Column(children: [
          FutureBuilder(
              future: _data,
              builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                  snapshot.hasData
                      ? Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: DropdownButton(
                            hint: Text(_displayState),
                            items: snapshot.data
                                .map((e) => DropdownMenuItem(
                                      child: Text(e["state_name"]),
                                      value: e["state_id"],
                                    ))
                                .toList(),
                            onChanged: (value) {
                              _selectindex = value;
                              setState(() {
                                _selectindex = value;
                                print("State" + _selectindex.toString());
                                _district =
                                    StateManager().loadData(_selectindex);
                              });
                            },
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        )),
          _district == null
              ? Text("Hello")
              : FutureBuilder(
                  future: _district,
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) =>
                          snapshot.hasData
                              ? DropdownButton(
                                  hint: Text(_displayDistrict),
                                  items: snapshot.data
                                      .map((e) => DropdownMenuItem(
                                            child: Text(e["district_name"]),
                                            value: e["district_id"],
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    _displayDistrict =
                                        snapshot.data[value]["district_name"];
                                    setState(() {
                                      _displayDistrict =
                                          snapshot.data[value]["district_name"];
                                      print(_displayDistrict);
                                    });
                                  },
                                )
                              : Center(
                                  child: CircularProgressIndicator(),
                                ),
                )
        ]));
  }
}
