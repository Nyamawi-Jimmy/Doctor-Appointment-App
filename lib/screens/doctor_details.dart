
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Dimensions/dimensions.dart';
import '../Widgets/button.dart';
import '../Widgets/custom_appbar.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({Key? key}) : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {

  //For favourite
  bool isFav =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppbar(
        appTitle: "Doctor Details",
        icon: FaIcon(Icons.arrow_back_ios),
        action: [
          IconButton(onPressed: (){
            setState(() {
              isFav=!isFav;
            });
          },
              icon: FaIcon(isFav?Icons.favorite_rounded:Icons.favorite_outline,color:
              Colors.redAccent,))
        ],
      ),
      body: SafeArea(
          child: Column(
            children: [
              //Circle avatar and  intro
              AboutDoctor(),
              Padding(padding: EdgeInsets.all(20),
              child: Button(
                width: double.infinity,
                title: "Book Appointment",
                onPressed: () {
                  Navigator.of(context).pushNamed("booking_page");
                },
                disable: false,
              ),
              ),

            ],
          ),

      ),
    );
  }
}

class AboutDoctor extends StatelessWidget {
  const AboutDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          CircleAvatar(
            radius: 65,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage(
              "assets/images/jimmy.JPG"
            ),
          ),
          Dimensions.spacesmall,
          Text("Dr Jimmy Nyamawi",style: TextStyle(
              color: Colors.black,
          fontSize: 20,
            fontWeight: FontWeight.bold
          ),),
          Dimensions.spacesmall,
          SizedBox(
            width: Dimensions.widthsize*0.75,
            child: Text(
              //"Kenyatta National Hospital (KNH),Aga Khan University Hospital (AKUH),Nairobi Hospital (NRB)Moi Teaching and Referral Hospital (MTRH),Coast General Hospital (CGH)",
              "Kenya Medical Training College (KMTC), Kenya Methodist University School of Medicine and Health Sciences (KMU-SMHS))",
              style: TextStyle(fontSize: 15,color: Colors.grey),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          Dimensions.spacesmall,
          SizedBox(
            width: Dimensions.widthsize*0.75,
            child: Text(
              "Kenyatta National Hospital (KNH)",
              style: TextStyle(fontSize: 15,color: Colors.black,
              fontWeight: FontWeight.bold),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
      Dimensions.spacesmall,
          DetailsBody(),
        ],
      ),
    );
  }
}

class DetailsBody extends StatelessWidget {
  const DetailsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //DOctors exp,patients and rating
          DoctorInfo(),
          Dimensions.spacesmall,
          Text("About Doctor",style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 10,),
          Text("Dr. Jimmy Nyamawi is a highly experienced dentist who has made a significant impact in the field of dentistry. With years of practice under his belt, Dr. Nyamawi has gained a reputation as a knowledgeable and skilled practitioner who is dedicated to providing his patients with the best possible dental care.",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 1.5
            ),
              softWrap: true,
              textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
       InfoCard(
           label: "Patients",
           value: "109"),
        SizedBox(width: 15,),
        InfoCard(
            label: "Experiences",
            value: "10 Years"),
        SizedBox(width: 15,),
        InfoCard(
            label: "Rating",
            value: "4.6")
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final String label;
  final String value;
  const InfoCard({Key? key,
    required this.label,
    required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Expanded(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Dimensions.primarycolor
          ),
          padding: EdgeInsets.symmetric(vertical: 30,horizontal: 15),
          child: Column(
            children: [
              Text(label,style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black
              ),),
              SizedBox(height: 10,),
              Text(value,style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: Colors.white
              ),)
            ],
          ),
        ));
  }
}




