import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_demo_1/common/UserLocalStore.dart';
import 'package:ui_demo_1/common/bottom_bar.dart';
import 'package:ui_demo_1/login_frame/edit_profile_page.dart';
import 'package:ui_demo_1/login_frame/forgot_password.dart';
import 'package:ui_demo_1/login_frame/register_page.dart';
import 'package:ui_demo_1/main.dart';
import 'package:ui_demo_1/mainframe/home_page.dart';


class login_page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => login_page_();  
}

class login_page_ extends State<login_page>{  

       //CONTROLLER FOR TEXTFORM_FIELD
       final get_number_ = new TextEditingController();
       final get_password_ = new TextEditingController();
        

      Color btn_clr = Color(0xff1a95d1);
      GlobalKey<FormState> formkey = new GlobalKey();
      bool _obscureText = true;

       //PASSWORD VISIBILITY
       void _togglePasswordStatus() {
             setState(() {
             _obscureText = !_obscureText;
    });
  }       
        
         @override
         void initState()
         {
          super.initState();
          isUserLogged();              
         }  

  void StoreData(String number_) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("number", number_);
    preferences.commit();
  }       

  void isUserLogged() async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String  getNumber = preferences.getString("number").toString();
      if(getNumber != null ){
        Fluttertoast.showToast(msg: getNumber);
          //pushToHome();
      }
  }     


  @override
  Widget build(BuildContext context) {
     return Scaffold(       
         resizeToAvoidBottomInset : true,//FOR AVOIDING DISPLAYING WIDGET OVER THE KEYPAD
          body: SingleChildScrollView(                      
               child: Container(
                 padding:EdgeInsets.fromLTRB(20, 0, 20, 0) ,
                 child: Form(
                   key: formkey,
                   child: Theme(
                          data:Theme.of(context).copyWith(
                          colorScheme: ThemeData().colorScheme.copyWith(
                          primary:Colors.grey,),),
                     child: Column(
                       children: <Widget>[
                         Align(
                           alignment: Alignment.center,
                           child:  Image.asset('assets/buyaway.png',width: 300,height: 300),
                         ),
                         SizedBox(
                           height: 30,
                         ),
                         new Container(
                           child: TextFormField(
                             controller: get_number_,
                             keyboardType: TextInputType.number,
                             inputFormatters: [new LengthLimitingTextInputFormatter(10),],
                             style: TextStyle(color: Colors.black,fontFamily: 'Poppins',fontSize: 14 ),
                             decoration: InputDecoration(prefixIcon: Icon(Icons.call),                              
                             border: UnderlineInputBorder(),labelText: 'Primary Number',
                             ), 
                             validator: (value){
                               if(value!.isEmpty){
                                 return "Enter Primary Number";
                               }else if(value.length < 10){
                                 return "Enter valid Primary Number";
                               }
                               return null;
                             }, 
                           ),
                         ),
                         SizedBox(
                           height: 20,
                         ),
                         new Container(
                           child: TextFormField(
                             controller: get_password_,
                             obscureText: _obscureText,
                             style: TextStyle(color: Colors.black,fontFamily: 'Poppins',fontSize: 14 ),
                             decoration: InputDecoration(prefixIcon: Icon(Icons.lock),                              
                             border: UnderlineInputBorder(),labelText: 'Password',
                             suffixIcon: IconButton(onPressed:  _togglePasswordStatus,
                              icon: Icon(_obscureText  ?  Icons.visibility : Icons.visibility_off))
                             ), 
                            validator: (value){
                               if(value!.isEmpty){
                                 return "Enter E-mail Id";
                               }
                               return null;
                             }, 
                           ),
                         ),
                         SizedBox(height: 30,),
                         SizedBox(
                           width: double.infinity,
                           child: Container(
                             child: ElevatedButton(
                               onPressed: (){  
                                   StoreData(get_number_.text);
                                   if(formkey.currentState!.validate()){                                       
                                       pushToHome();
                                       }else{
                                      Fluttertoast.showToast(msg: "Something gone wrong..!");
                                    }  
                                },
                                 child: Text("LOGIN",style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),),
                                 style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(btn_clr)),
                               ),
                           ), 
                         ),
                         SizedBox(height: 30,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                             TextButton(onPressed: (){
                               Navigator.push(context, 
                               MaterialPageRoute(builder: (context) => register_page() ));
                             },
                              child: Text('Sign up here',style: TextStyle(color: btn_clr ))),                    
                             Text(' | ',style: TextStyle(color: Colors.black )),
                             TextButton(onPressed: (){                         
                               Navigator.push(context,
                               MaterialPageRoute(builder: (context) => forgot_password() ) );                
                              },
                              child: Text('Forgot Password',style: TextStyle(color: btn_clr )))
                           ],
                         )
                       ],
                     ),
                   ),
                 ),
               ),
                     
            
          ),
       );
  }
 
  

   void pushToHome( ){
     Navigator.push(context, (MaterialPageRoute(
       builder: (context) =>  btm_app_bar()
       ) ));
   }
  
   
}