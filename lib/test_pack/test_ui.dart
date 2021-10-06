import 'package:flutter/material.dart';

class test_ui extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => test_ui_();

}

class test_ui_ extends State<test_ui>{
 
 double _width = 200 ;
 double _height = 170 ;


 void _setState(){
      
      //_width = 400 ;
      _height = 300 ;

 }


  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: Container(
         margin: EdgeInsets.all(15.0),
         child: Stack(
           children: <Widget>[ 
             SizedBox(
               height: 100,
               width: 100,
             ),
              RaisedButton(onPressed: (){
                setState(() {
                  _setState();
                });
              }),          
              Center(
                 child: AnimatedContainer(
               duration: (Duration(milliseconds: 2000)),
                child: Container(                          
                       width: double.infinity,
                       height: _height,
                       decoration: BoxDecoration(
                       image: DecorationImage(
                       fit: BoxFit.cover, image: NetworkImage('http://webbuyaway.buyaway.in/branditemimage/v214300221.jpg')),
                       borderRadius: BorderRadius.all(Radius.circular(15.0)),
                       color: Colors.white,                  ),
                                    ),
                     
                 ),
                  ),

                  /*child: AnimatedContainer(
                  duration: (Duration(milliseconds: 900)),
                    height: _height,
                    child: Text(
                      "Praveen", style: TextStyle(color: Colors.black,
                       fontFamily: 'Poppins', fontSize: 18),
                    ),)*/

                /*child: AnimatedContainer(
                  duration: Duration(milliseconds: 900),
                  width: _width,
                  height: _height,
                  color: Colors.blue[200],
                  child: Center(                    
                    child: Text(
                      "Praveen", style: TextStyle(color: Colors.black,
                       fontFamily: 'Poppins', fontSize: 18),
                    ),
                  ),
                ), */           
            
            ],
         ),
       ),
     );
  }

}