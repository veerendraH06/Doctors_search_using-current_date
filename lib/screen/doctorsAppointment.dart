import 'dart:convert';

import 'package:doctor_appointment/common/colors.dart';
import 'package:doctor_appointment/common/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class DoctorsAppoint extends StatefulWidget {
  @override
  _DoctorsAppointState createState() => _DoctorsAppointState();
}

class _DoctorsAppointState extends State<DoctorsAppoint> {
  DatePickerController _controller = DatePickerController();

  DateTime _selectedValue = DateTime.now();

  final String url = "assets/doctors.json";
  List<dynamic> allData = [];
  List<dynamic> appointmentData = [];
  Map<String, dynamic> appointment;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    this.getjsondata();
  }

  Future<String> getjsondata() async {
    String jsonData =
        await DefaultAssetBundle.of(context).loadString("assets/doctors.json"); /// loding data from json
    final List<dynamic> jsonResult = json.decode(jsonData);

    allData = jsonResult;
  }

  getSelectedDateAppointments() {
    //   for (var i = 0; i < allData.length; i++) {
    //     Map<String, dynamic> appItem = allData[i];
    //     if (appItem['date'] == _selectedValue.toString()) {
    //       print(appItem);
    //     }
    //
    // }
    appointmentData = allData.where((element) {

      Map<String, dynamic> appItem = element;
      return appItem['date'] == _selectedValue.toString(); /// matching data from json
    }).toList();
    print(appointmentData);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: DoctorColors.Dblue,
        title: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
                height: 40,
                width: 40,
                child: Image.network(
                    "https://image.freepik.com/free-photo/doctor-smiling-pointing-finger-up_23-2148075680.jpg")),
          ),
          title: Text(
            "Welcome Dr. Scilaris",
            style: TextStyle(color: DoctorColors.Dw),
          ),
          trailing: Icon(Icons.menu, color: DoctorColors.Dw),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //color: Colors.black,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.06,
              color: DoctorColors.Dblue,
            ),
            Positioned(  /// search patient card position
              top: MediaQuery.of(context).size.width * 0.03,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Column(
                  children: [
                    Card( /// card for search bar and icon
                      elevation: 20.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Container(
                        margin: EdgeInsets.only(top: 0.0),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.080,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: TextFormField(
                                decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        const EdgeInsets.only(bottom: 0),
                                    hintText: "Search Patients"),
                              ),
                              trailing: Container(
                                child: Icon(
                                  Icons.search,
                                ),
                                padding: const EdgeInsets.only(bottom: 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          DatePicker( /// calling date picker from user
                            DateTime.now(),
                            initialSelectedDate: DateTime.now(),
                            selectionColor: DoctorColors.Dblue,
                            selectedTextColor: DoctorColors.Dw,
                            onDateChange: (date) {
                              // New date selected
                              setState(() {
                                _selectedValue = date;
                                print(_selectedValue);
                                getSelectedDateAppointments();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Stack(
                children: <Widget>[
                  SafeArea(
                    bottom: false,
                    child: Stack(
                      children: <Widget>[
                        DraggableScrollableSheet(
                          maxChildSize: .8,
                          initialChildSize: .6,
                          minChildSize: .6,
                          builder: (context, scrollController) {
                            return Container(
                              height: 100,
                              padding: EdgeInsets.only(
                                  left: 19,
                                  right: 19,
                                  top:
                                      16), //symmetric(horizontal: 19, vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)),
                                color: Colors.white,
                              ),
                              child: SingleChildScrollView(
                                // physics: BouncingScrollPhysics(),
                                controller: scrollController,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "HEMA 54-DEAN (4)",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        )
                                      ],
                                    ),
                                    appointmentData != null &&   /// checking condition and printing values in list view
                                            appointmentData.isNotEmpty
                                        ? ListView.separated(
                                            separatorBuilder:
                                                (context, index) => Divider(
                                              color: Colors.black,
                                            ),
                                            shrinkWrap: true,
                                            itemCount: appointmentData.length,
                                            itemBuilder: (context, index) {
                                              Map<String, dynamic> item =
                                                  appointmentData[index];   /// convert note data to map
                                              return ListTile(
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                                leading: Icon(
                                                  Icons.bookmark,
                                                  color: Colors.green,
                                                ),
                                                title: Text(item["name"]),
                                                subtitle: Text(item["Doctors name"] +
                                                    "\n" +
                                                    item["Hospital"]),
                                                trailing: Column(
                                                  children: [
                                                    Text(item["time"]),
                                                    Spacer(),
                                                    RichText(
                                                      text: TextSpan(
                                                        text: '• ',
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 14),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: 'time' +
                                                                "" +
                                                                "" +
                                                                item["status"],
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          )
                                        : Container(
                                            child: Text(
                                            "No Appointments",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueGrey),
                                          )),
                                    Divider(
                                      thickness: .5,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: DoctorColors.Dblue,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
