import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

      List data_ =  json.decode(data.body) ;
          
            /*data_.forEach((element){
               Map obj = element;
               String tite = obj['title'];
                
               List store_list = obj['StoreandStock'] ;
                store_list.forEach((element_s){
                    Map obj_s = element_s;
                    String store_name = obj_s['store_name'];
                    print(store_name);
                });                   
                  }); */ 
                                              
        // print(jsonData.toString()); 


    List<ProductModel> models = [];


    for(var u in jsonData){

          var get_list = u["StoreandStock"];  

           print("HINT"+get_list.toString());  
           
       ProductModel model_ = ProductModel ( u["category_id"], u["brand_id"],
       u["brand_name"], u["title"], u["product_image"], u["brand_item_id"] ,
        get_list );
        
      
       models.add(model_);

    }

    print(models.length);

    return models;


}



class offers_page_ extends State<offers_page>{
   
   double _height = 140 ;
   int currentPosition = 0 ; 
   int ClickedPosition =  0 ; 

   void _setState(int _index){ 
      if(currentPosition == _index )  {
        _height = 140 ;
      }         
 }  
  
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
                            var children2 = <Widget>[ 
                               AnimatedContainer(                                   
                                   margin: EdgeInsets.only(top: (currentPosition == index ? _height : 0)),
                                   duration: Duration(milliseconds: 700),
                                   height: 160, width: double.infinity,
                                   decoration: BoxDecoration(
                                   color: Colors.white, // added
                                   borderRadius: BorderRadius.circular(25.0),),
                                   ),                     
                                     InkWell(
                                                   child: Container(                          
                                                    width: double.infinity,
                                                    height: 170.0,
                                                    decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                    fit: BoxFit.cover, image: NetworkImage('http://webbuyaway.buyaway.in'+snapshot.data[index].product_image )),
                                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                    color: Colors.white,),                                                    
                                                    ),               
                                                    onTap: (){
                                                      setState(() {
                                                        Fluttertoast.showToast(msg:  index.toString());
                                                             _setState(index); 
                                                              currentPosition =  index;
                                                                 });
                                                    },                                    
                                                 ),
                                                setText(90 ,snapshot.data[index].brand_name),
                                                setText(120 ,snapshot.data[index].title),
                                                 ];
                            return Container(
                              margin: EdgeInsets.only(left: 5.0,right: 5.0, top: 10.0),
                              child: Column(
                                children: <Widget>[
                                   SizedBox(height: 5,),
                                   Container(
                                     child: Material(
                                       elevation: 3,
                                       borderRadius: BorderRadius.circular(10),
                                       child: Stack(
                                          children: children2, ),
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



Widget setText(double height_,String data){
  return Container(   margin: EdgeInsets.only(left: 15,top: height_),
         child: Text( data,
         style: TextStyle(color: Colors.white, fontFamily: 'Poppins',
         fontSize: 18, fontWeight: FontWeight.bold )));  
         

}
 

class ProductModel{

 
  final String category_id; 
  final String brand_id; 
  final String brand_name; 
  final String title; 
  final String product_image; 
  final String brand_item_id;
    var StoreandStock_;
   
  ProductModel(
    this.category_id,
    this.brand_id,
    this.brand_name,
    this.title,
    this.product_image,
    this.brand_item_id,
    this.StoreandStock_
   );

}

class StoreandStock{
   
    String stock_id ;
    String store_id ;
    String store_name ;
    String availability ;
    String status ;
    String offer_tag ;
    String latitude ;
    String longitude ; 

StoreandStock(
    this.stock_id,
    this.store_id,
    this.store_name,
    this.availability,
    this.status,
    this.offer_tag,
    this.latitude,
    this.longitude
  );

   

}


