import 'package:flutter/material.dart';
import 'package:ui_demo_1/ModelClass/ProductModel.dart';
import 'package:ui_demo_1/common/search_bar.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';



class offers_page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => offers_page_();

}


Future<List<ProductModel>>  load_products() async {
    final String  apiUrl = "http://webbuyaway.buyaway.in/api/APIMobileStoreList/MobileStoreList";
    
    final data = await http.post(Uri.parse(apiUrl), body: {
  });

     var jsonData = json.decode(data.body);

         print(jsonData.toString()); 


    List<ProductModel> models = [];


    for(var u in jsonData){

      ProductModel model_ = ProductModel (u["category_id"], u["brand_id"],
       u["brand_name"], u["title"], u["product_image"], u["brand_item_id"]);

      models.add(model_);

    }

    print(models.length);

    return models;


}



class offers_page_ extends State<offers_page>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(    
     body: Column(
       children: <Widget>[
        SizedBox(height: 40,), 
        Search_bar(inputText: "Search Product" ),  SizedBox(height: 0,),
        Expanded(
          child: Container(
                  margin: EdgeInsets.only(left: 5,right: 5,top: 0),
                   child: FutureBuilder(
                     future: load_products(),                 
                     builder: (BuildContext context, AsyncSnapshot snapshot){
                       if(snapshot.data == null ){
                          return Center(
                            child: Text("Loading..."),
                          );
                       }else {
                       return  ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(left: 5.0,right: 5.0, top: 10.0),
                              child: Column(
                                children: <Widget>[
                                   SizedBox(height: 5,),
                                   Container(
                                     child: Stack(
                                        children: <Widget>[                   
                                                 Container(                          
                                                   width: double.infinity,
                                                   height: 170.0,
                                                   decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                  fit: BoxFit.cover, image: NetworkImage('http://webbuyaway.buyaway.in'+snapshot.data[index].product_image )),
                                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                  color: Colors.white,                  ),
                                               ),
                                                
                                               Container(
                                                 margin: EdgeInsets.only(left: 15,top: 90),
                                                 child:   setText(snapshot.data[index].brand_name)
                                               ), 
                                                Container(
                                                 margin: EdgeInsets.only(left: 15,top: 120),
                                                 child:  setText(snapshot.data[index].title) 
                                               ),                                              
                                                        
                                  ],
                                ),
                              ),
                                ],
                              ),                          
                            );
                          });
                       }
                     }
                 ),
           ),
        ),],
     )
   );
  }

}

Text setText(String data){
  return Text(
           data,
         style: TextStyle(color: Colors.white, fontFamily: 'Poppins',
          fontSize: 18, fontWeight: FontWeight.bold ));  
}
 


class ProductModel{
 
 
 
  final String category_id; 
  final String brand_id; 
  final String brand_name; 
  final String title; 
  final String product_image; 
  final String brand_item_id; 
  
  ProductModel(
    this.category_id,
    this.brand_id,
    this.brand_name,
    this.title,
    this.product_image,
    this.brand_item_id
  );

}


/*
 Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 60),
               child: FutureBuilder(
                 future: load_products(),
                 builder: (BuildContext context, AsyncSnapshot snapshot){
                   return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.all(15.0),
                        child: Column(
                          children: <Widget>[
                            Text(snapshot.data[index].brand_name, 
                             style:  TextStyle(fontSize: 18, fontFamily: 'Poppins', color: Colors.black, fontWeight: FontWeight.bold),),
                            SizedBox(height: 15,),
                            Text(snapshot.data[index].title, 
                             style:  TextStyle(fontSize: 15, fontFamily: 'Poppins', color: Colors.grey, ),),
                           
                          ],
                        ),
                        
                      );
                    });
                 }
                 ),
       )
* */