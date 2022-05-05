import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

Widget defultFormFieled({
  required TextEditingController controller ,
  required TextInputType type ,
  bool isPassword = false ,
  bool isClicable = true,
  Function(String)? onSubmit ,
  Function(String)? onChange ,
  Function()? onTap ,
  required String? Function (String?) validate ,
  required String label ,
  required IconData prefix ,
  IconData? suffix ,
  Function()? suffixPressed

}) =>
TextFormField(
  controller:controller ,
  keyboardType: type,
  obscureText: isPassword ,
  enabled: isClicable ,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  onTap: onTap ,
  validator:validate ,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(prefix) ,
    suffixIcon: suffix != null
        ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
        : null,
    border: OutlineInputBorder()
  ),
) ;

Widget defaultBotton ({
  double width = double.infinity ,
  Color background = Colors.deepOrange ,
  bool isUpperCase = true ,
  double radius =3 ,
  required Function() function ,
  required String text
}) => Container(
  width: width,
  height: 50,
  child: MaterialButton(
    onPressed: function ,
    child: Text(
      isUpperCase ? text.toUpperCase() : text ,
      style: TextStyle(
        color: Colors.white
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background
  ),
) ;

Widget defaultTextButton({
  required Function() function ,
required String text ,
}
) => TextButton(onPressed: function, child: Text(text.toUpperCase())) ;

/*Widget builtOnBoardingItem(OnBoardingModel model) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(child: Image(image: AssetImage('${model.image}'),
      fit: BoxFit.cover,
    )),
    SizedBox(height : 30) ,
    Text(
      '${model.title}' ,
      style:TextStyle ( fontSize: 24 ) ,) ,
    SizedBox(height : 15) ,
    Text(
      '${model.body}' ,
      style:TextStyle ( fontSize: 14 ) ,) ,

  ],
) ; */

void showToast({
  required String msg  ,
}) => Fluttertoast.showToast(
  msg: msg ,
  toastLength: Toast.LENGTH_LONG ,
  gravity: ToastGravity.BOTTOM ,
  timeInSecForIosWeb: 5 ,
  backgroundColor: HexColor('589ac7') ,
  textColor: Colors.white ,
  fontSize: 15
);


enum ToastStates {SUCCESS , ERROR , WARNING}

Color chooseToastColor (ToastStates state) {

  Color color ;
  switch(state){
    case ToastStates.SUCCESS : color = Colors.green ;
    break ;
    case ToastStates.ERROR : color = Colors.red ;
    break ;
    case ToastStates.WARNING : color = Colors.amber ;
  break ;
  }
  return color ;

}

void printFullText (String text){
  final pattern = RegExp('.{1,800}') ; //800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));

}

String? token ='';
String? email = '' ;