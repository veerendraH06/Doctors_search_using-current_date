import 'package:doctor_appointment/common/colors.dart';
import 'package:doctor_appointment/component/playicon.dart';
import 'package:doctor_appointment/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Details_Page extends StatefulWidget {
  @override
  _Details_PageState createState() => _Details_PageState();
}

class _Details_PageState extends State<Details_Page> with SingleTickerProviderStateMixin{
  bool switchControl = false;
  var textHolder = 'Switch is OFF';

  AnimationController _animationController;
  bool isPlaying = true;

  @override
  void initState() {
    setState(() {
      _animationController =
          AnimationController(vsync: this, duration: Duration(milliseconds: 450));

    });
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jonathan Hill"),
        backgroundColor: DoctorColors.Dblue,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(

                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        "https://miro.medium.com/max/280/1*MccriYX-ciBniUzRKAUsAw.png"),
                    radius: 60,
                  ),
                  margin: EdgeInsets.only(left: 10, top: 0),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: Column(
                    children: [
                      Text(
                        "02-12-2021",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "PC - MD",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Kdhkjdsssa, kmdk ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "(Male)",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Pending",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  margin: EdgeInsets.only(left: 20, top: 0),
                ),
              ],
            ),
            Row(
              children: [
                Text("In Seat File",style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Transform.scale(
                      scale: 1.5,
                      child: Switch(
                        onChanged: toggleSwitch,
                        value: switchControl,
                        activeTrackColor: DoctorColors.Dg,
                        inactiveThumbColor:DoctorColors.Dblue,
                        inactiveTrackColor: DoctorColors.Dgre,
                      )),

                  // Text('$textHolder', style: TextStyle(fontSize: 24),)
                ]),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                FlatButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayIcon()));
                },
                    child: Container(
                      child: Icon(
                        Icons.mic,size: 40,color: DoctorColors.Dw,),
                      width: MediaQuery.of(context).size.width *0.20,
                      height: MediaQuery.of(context).size.height *0.10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: DoctorColors.Dblue),
                    ),
                ),
                FlatButton(onPressed: (){
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => CupertinoActionSheet(
                        title: const Text('Choose Options'),
                        message: const Text('Your options are '),
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                            child: const Text('Camera'),
                            onPressed: () {
                              print("Camera");
                              // Navigator.pop(context, 'One');
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: const Text('Photo Gallery'),
                            onPressed: () {
                              print("Photo Gallery");
                              // Navigator.pop(context, 'Two');
                            },
                          )
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          child: const Text('Cancel'),
                          isDefaultAction: true,
                          onPressed: () {

                            Navigator.pop(context, 'Cancel');
                          },
                        )),
                  );
                },
                  child: Container(
                    child: Icon(
                      Icons.camera,size: 40,color: DoctorColors.Dw,),
                    width: MediaQuery.of(context).size.width *0.20,
                    height: MediaQuery.of(context).size.height *0.10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: DoctorColors.Dblue),
                  ),
                ),
              ],
            ),
          Container(
            child:  Card(child: Column(
              children: [
                ListTile(title: Text("Date-of-Birth"),trailing: Text("02-17-1986"),),
                ListTile(title: Text("Case No"),trailing: Text("Y201245845")),
                ListTile(title: Text("PC-MO"),trailing: Text("Checkout")),
              ],


            ),),
          ),

                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  color: Color.fromRGBO(191, 193, 199, 1),
                  child: ListTile(
                    leading: Icon(Icons.file_copy,color: DoctorColors.Dblue,size: 40,),
                    title: Text("Super Bill",style: TextStyle(color: DoctorColors.Dblue,fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  color: Color.fromRGBO(191, 193, 199, 1),
                  child: ListTile(
                    leading: Icon(Icons.file_copy,color: DoctorColors.Dblue,size: 40,),
                    title: Text("Super Bill",style: TextStyle(color: DoctorColors.Dblue,fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                ),



          ],
        ),
      ),
    );
  }

  void toggleSwitch(bool value) {
    if (switchControl == false) {
      setState(() {
        switchControl = true;
        // textHolder = 'Switch is ON';
      });
      print('Switch is ON');
      // Put your code here which you want to execute on Switch ON event.

    } else {
      setState(() {
        switchControl = false;
        // textHolder = 'Switch is OFF';
      });
      print('Switch is OFF');
      // Put your code here which you want to execute on Switch OFF event.
    }
  }

}

