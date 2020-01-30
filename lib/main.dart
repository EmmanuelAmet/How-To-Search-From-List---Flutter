import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
  debugShowCheckedModeBanner: false,
  home: new Home(),
));

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeState();
}

class HomeState extends State<Home> {
  List<String> items = [
    "Emmanuel",
    "Grace",
    "Benedicta",
    "Henry",
    "Fiona",
    "Nathan",
    "Stephan",
  ];
  TextEditingController controller = new TextEditingController();
  String filter;
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("Search");

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _search(){
    setState(() {
      if ( this.actionIcon.icon == Icons.search){
        this.actionIcon = new Icon(Icons.close);
        this.appBarTitle = new TextField(
          controller: controller,
          style: new TextStyle(color: Colors.white,),
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search,color: Colors.white),
              hintText: "Search...",
              hintStyle: new TextStyle(color: Colors.white)
          ),
        );}
      else {
        this.actionIcon = new Icon(Icons.search);
        this.appBarTitle = new Text("AppBar Title");
      }
    });
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: _search,
          ),
        ],
      ),
      body: new Column(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(top: 20.0),
          ),
          new Expanded(
              child: new ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return filter == null || filter == ""
                      ? new ListTile(leading: Icon(Icons.person_pin, color: Colors.red,), title: new Text(items[index]), trailing: Icon(Icons.arrow_forward, color: Colors.red,), onTap: (){
                    search(context);
                  },)
                      : items[index].toLowerCase().contains(filter.toLowerCase())
                      ? new ListTile(leading: Icon(Icons.person_pin, color: Colors.red,), title: new Text(items[index]), trailing: Icon(Icons.arrow_forward, color: Colors.red,), onTap: (){
                        search(context);
                  },)
                      : new ListTile(onTap: (){
                    search(context);
                  });
                },
              ))
        ],
      ),
    );
  }

  void search(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Alert'),
            content: Text('Do you want to call this number?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    //_openURLCall();
                  },
                  child: Text('PROCEED')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('CANCEL'))
            ],
          );
        });
  }
}