import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Dimensions/dimensions.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget{
  final String? appTitle;
  final String? route;
  final FaIcon? icon;
  final List<Widget>? action;

  const CustomAppbar({Key? key,
    this.appTitle,
    this.route,
    this.icon,
    this.action}) : super(key: key);

  @override
  Size get preferredSize=> const Size.fromHeight(60);

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();

}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      elevation: 0,
      backgroundColor: Colors.white,
      title: Center(
        child: Text(
          widget.appTitle!,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      leading: widget.icon!=null?Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Dimensions.primarycolor
        ),
        child: IconButton(
          onPressed: (){
            //If route is given then move to the next route
            if(widget.route!=null){
              Navigator.of(context).pushNamed(widget.route!);
              //just pop back to the previous page
            }else{
              Navigator.of(context).pop();
            }
          },
          icon: widget.icon!,
          iconSize: 15,
          color: Colors.white,
        ),
      ):null,
      //if action is not set then return null
      actions: widget.action??null,
    );
  }
}
