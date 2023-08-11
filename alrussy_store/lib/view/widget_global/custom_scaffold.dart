
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomScaffold extends StatelessWidget {
   CustomScaffold({Key? key,required this.child,required this.title,required this.icon,this.onPressed,}) : super(key: key);
 final Widget child;
 String? title;
 void Function()? onPressed;
 IconData? icon;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: Column(
          children:[
             Padding(padding:EdgeInsets.only(top: 20,right: 15,left: 15),
                 child: getCustomAppbar(context,title,onPressed,icon)),
            Expanded(
              child: Container(
              padding: EdgeInsets.only(top:5,left: 15,right: 15),
                child: child,),
            ),
          ],
        )
      )
    );
  }
}
getCustomAppbar(context,title,onPressed,icon){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child:
      Center(child:
      Text(title,style: Theme.of(context).textTheme.titleLarge,))),
      InkWell(
        onTap:onPressed,
        child: Container(
          height: 50,
          width: 50,
          child: Icon(icon,color: Colors.black),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xffECECEC)),
              borderRadius: BorderRadius.circular(10)
          ) ,
        ),
      ),
    ],
  );
}
