import 'package:flutter/material.dart';



 


/*class MyPage extends StatelessWidget {
  List<Widget> _getChildren(int count, String name) 
  => List<Widget>.generate(
        count,
        (i) => ListTile(title: Text('$name$i')),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ExpansionTile(
            title: Text('List-A'),
            children: _getChildren(4, 'A-'),
          ),
          ExpansionTile(
            title: Text('List-B'),
            children: _getChildren(3, 'B-'),
          ),
        ],
      ),
    );
  }
}*/

class Page_IS extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return Scaffold(
        body: Container(
          margin: EdgeInsets.all(15),
          child: ListView(           
            children: [
              Material(            
                borderRadius: BorderRadius.circular(15),
                elevation: 10,               
                child: ExpansionTile(
                  iconColor: Colors.transparent,
                title: Container(
                     width: double.infinity,
                     height: 170.0,
                    decoration: BoxDecoration(
                          image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage('http://webbuyaway.buyaway.in/branditemimage/v214300221.jpg')),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          color: Colors.white,),      ),
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 0),
                         height: 180,
                        width: 300,
                        decoration: BoxDecoration(
                        color: Colors.white, // added
                      borderRadius: BorderRadius.circular(25.0),),                      
                    )
                  ],),
              )
            ],
          ),
        ),
     );
  }

}
