import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../Dimensions/dimensions.dart';
import '../Providers/dio_prov.dart';
import '../Widgets/button.dart';
import '../Widgets/custom_appbar.dart';
import '../main.dart';
import '../models/book_datetime_convert.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {

  CalendarFormat _format=CalendarFormat.month;
  DateTime _focusDay=DateTime.now();
  DateTime _currentDay=DateTime.now();
  int? _isCurrentIndex;
  bool _isWeekend =false;
  bool _isDateSelected=false;
  bool _isTimeSelected=false;
  String? token;
  Future <void> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
  }
  @override
  void initState(){
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final doctor=ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: CustomAppbar(
        appTitle: "Appointment",
        icon: FaIcon(Icons.arrow_back_ios),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                //table calendar to be displayed here
                _tableCalendar(),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  child: Center(
                    child: Text("Select Consultation Time",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,

                    ),),
                  ),
                )
              ],
            ),
          ),
          _isWeekend?SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 20,left: 10,right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      width: 2,
                      color: Dimensions.primarycolor
                  )
              ),
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 35),
              alignment: Alignment.center,
              child: Text("Weekend is not available,please select another date",style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.blueAccent
              ),),
            ),
          ):SliverGrid(delegate:SliverChildBuilderDelegate((context,index){
            return InkWell(
              splashColor: Colors.transparent,
              onTap: (){
                setState(() {
                  _isCurrentIndex=index;
                  _isTimeSelected=true;
                });
              },
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: _isCurrentIndex==index?Colors.white:
                      Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: _isCurrentIndex==index?Dimensions.primarycolor
                        :null
                ),
                alignment: Alignment.center,
                child: Text(
                  "${index+9}:00 ${index+9>11? "PM":"AM"}",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _isCurrentIndex==index?Colors.white:null
                ),
                ),
              ),
            );
          },
              childCount: 8
          ), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,childAspectRatio: 1.2)
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 50),
              child: Button(
                width: double.infinity,
                title: 'Make Appointment',
                onPressed: () async {
                  //print('nooo');
                  final getDate=DateConverted.getDate(_currentDay);
                  final getDay=DateConverted.getDay(_currentDay.weekday);
                  final getTime=DateConverted.getTime(_isCurrentIndex!);
                  final booking = await DioProvider().bookAppointment(getDay, getDate, getTime, doctor['doctor_id'], token!);
                  //print(booking);
                  if(booking==200){
                    MyApp.navigatorkey.currentState!.pushNamed("appointment_booked");
                  }else{
                    return 'error';
                  }


                },
                disable:_isTimeSelected && _isDateSelected?false:true,
              ),

            ),
          )
        ],
      ),
    );
  }

  Widget _tableCalendar(){
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2030,2,25),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
            color: Dimensions.primarycolor,
            shape: BoxShape.circle
        ),
      ),
      availableCalendarFormats: {
        CalendarFormat.month:"month",
      },
      onFormatChanged: (format){
        setState(() {
          _format=format;
        });
      },
      onDaySelected: (selectedDay,focusedDay){
        setState(() {
          _currentDay=selectedDay;
          _focusDay=focusedDay;
          _isDateSelected=true;
          if(selectedDay.weekday==6 ||selectedDay.weekday==7){
            _isWeekend=true;
            _isTimeSelected=false;
            _isCurrentIndex=null;
          }else{
            _isWeekend=false ;
          }
        });
      },
    );
  }
}