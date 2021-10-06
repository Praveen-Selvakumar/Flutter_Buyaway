import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ui_demo_1/ModelClass/CategoryModel.dart';
import 'package:ui_demo_1/common/search_bar.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';



class search_page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => search_page_();

}

Future<List<CategoryModel_>>  load_categories()  async{

      var url = Uri.parse('http://webbuyaway.buyaway.in/api/APIMobileCategory/CategoryList');   

 final response = await http.post(url, body: {
   });

      print(response.body);

    var jsonData = json.decode(response.body);
    
    List<dynamic> list = jsonData;

    List<CategoryModel_> users = [];
 
    for(var u in jsonData){
      
      CategoryModel_ user = CategoryModel_(u["id"], u["name"], u["item_type"], u["icon"], u["added_by"], u["added_date"]);
       
      users.add(user);
      
    }
    print(users.length);

    return users;
    
} 

class search_page_ extends State<search_page>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Container(
            margin: EdgeInsets.only(left: 20,right: 20,top: 60),
            child: FutureBuilder(
              future:  load_categories(),               
               builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                      title: Text(snapshot.data[index].name),
                      subtitle: Text(snapshot.data[index].item_type),
                      onTap: (){
                         

                      },
                    );
                  },
                );
              }
              }
            ),
     ),
   );
  }

}

class CategoryModel_ {
 
    String id ;
    String name ;
    String item_type ;
    String icon ;
    String added_by ;
    String added_date ;


  CategoryModel_( this.id, this.name, this.item_type, this.icon, this.added_by, this.added_date);
}