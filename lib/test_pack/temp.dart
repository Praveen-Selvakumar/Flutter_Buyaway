import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

 
class MyHomePage extends StatefulWidget {

   // MyHomePage({required Key key, required this.title}) : super(key: key);

 // final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List<User>> _getUsers() async {

       
    var url = Uri.parse('http://webbuyaway.buyaway.in/api/APIMobileNewProducts/NewProducts');   

    var data = await http.get(url);

    var jsonData = json.decode(data.body);

    print(jsonData.toString());

    List<User> users = [];

    for(var u in jsonData){

      User user = User(u["id"], u["title"], u["price"], u["added_date"], u["description"]);

      users.add(user);

    }

    print(users.length);

    return users;

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
      //  title: new Text(widget.title),
      ),
      body: Container(
          child: FutureBuilder(
            future: _getUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              print(snapshot.data);
              if(snapshot.data == null){
                return Container(
                  child: Center(
                    child: Text("Loading...")
                  )
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      /*leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          snapshot.data[index].picture                        ),
                      ),*/
                      title: Text(snapshot.data[index].title),
                      subtitle: Text(snapshot.data[index].price),
                      onTap: (){

                        Navigator.push(context, 
                          new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
                        );

                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      );
  }
}

class DetailPage extends StatelessWidget {

  final User user;

  DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(user.title),
        )
    );
  }
}


class User {
  final int id;
  final String title;
  final String price;
  final String added_date;
  final String description;

  User(this.id, this.title, this.price, this.added_date, this.description);

}