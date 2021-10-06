import 'package:flutter/material.dart';
import 'package:ui_demo_1/login_frame/edit_profile_page.dart';
import 'package:ui_demo_1/mainframe/home_page.dart';
import 'package:ui_demo_1/mainframe/offers_page.dart';
import 'package:ui_demo_1/mainframe/search_page.dart';

class btm_app_bar extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => btm_app_bar_(); 
}

class btm_app_bar_ extends State<btm_app_bar>{

 int _selectedIndex  = 0 ;
  

 void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final pageOptions = [
        home_page(),
        search_page(),
        offers_page(),
        edit_profile_page(),        
  ];
  

  @override
  Widget build(BuildContext context) {
    debugShowCheckedModeBanner: false;
   return Scaffold(          
         body:pageOptions[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[     
           BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/house.png'),size: 20,),
            label: 'Home',
          ),     
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/loupe.png'),size: 20,),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/tag.png'),size: 20,),
            label: 'Offers',
          ), 
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/user.png'),size: 20,),
            label: 'Profile',
          ),
           
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor : Colors.grey,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
       );
  }
   
  
  
}