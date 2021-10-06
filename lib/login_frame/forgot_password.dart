import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ui_demo_1/login_frame/login_page.dart';
import 'package:ui_demo_1/mainframe/home_page.dart';



class forgot_password extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => forgot_password_();
   
}

class forgot_password_ extends  State<forgot_password>{
 
  //GLOBAL key
  GlobalKey<FormState> formKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
     Color btn_clr = Color(0xff1a95d1);
     return Scaffold(
       body: Container(
         padding: EdgeInsets.only(left: 20, right: 20),
         child: Align(
           alignment: Alignment.center,
           child: Theme(
             data:Theme.of(context).copyWith(
                          colorScheme: ThemeData().colorScheme.copyWith(
                          primary:Colors.grey,),),
             child: SingleChildScrollView(
               child: Form(
                 key: formKey,
                 child: Column(
                    children: <Widget>[              
                       SizedBox(height: 120,),
                       Image.asset('assets/buyaway.png',width: 300,height: 300,),
                       SizedBox(height: 30,),
                       Text("Forgot Password?",style: TextStyle(fontFamily: 'Poppins', fontSize: 18, color: Colors.black,
                       fontWeight: FontWeight.bold ),),
                       SizedBox(height: 15,),
                       Text("Reset password Here", style: TextStyle(fontFamily: 'Poppins',fontSize: 14,color: Colors.grey),), 
                       SizedBox(height:18,),
                       TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [new LengthLimitingTextInputFormatter(10),],
                               
                      style: TextStyle(fontFamily: 'Poppins',color: Colors.black,fontSize: 15),   
                     decoration: const InputDecoration(prefixIcon: Icon(Icons.call),border: UnderlineInputBorder(),
                     labelText: 'Enter Your Phone Number',
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter Primary Number";
                      }else if(value.length != 10){
                         return "Enter Valid Primary Number";
                      }
                        return null;
                      
                    },
                 ),
                 SizedBox(height: 30,),
                 SizedBox(
                   width: double.infinity,          
                     child: ElevatedButton(onPressed: (){ 
                       if(formKey.currentState!.validate()){
                           Fluttertoast.showToast(msg: "Successfully Registered!");
                           Navigator.push(context, 
                           MaterialPageRoute(builder: (context) => login_page() ));
                       }                                                                       
                     }, child: Text(
                       "Forgot password",style: TextStyle(color: Colors.white),),
                       style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(btn_clr)),),  
                 ),
                 
                   
                   ],
                  ),
               ),
             ),
           ),
         ),
       ),
     );
  }

   

}