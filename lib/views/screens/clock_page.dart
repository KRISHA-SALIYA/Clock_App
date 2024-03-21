import 'dart:async';
import 'dart:math';
import 'package:calender_picker/date_picker_widget.dart';
import 'package:flutter/material.dart';
import '../componets/clock_option.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  DateTime d = DateTime.now();

  int days = 8;
  bool _isAnalog = false;
  bool _isStrap = false;
  bool _isDigital = false;
  bool _isCalender = false;
  bool _image = false;

  int hour = 0;
  int minute = 0;
  int second = 0;

  List month = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "July",
    "Aug",
    "Sep",
    "Oct",
    "Nev",
    "Des",
  ];

  List weekday = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  void startClock() {
    Future.delayed(const Duration(seconds: 1), () {
      d = DateTime.now();
      setState(() {});
      startClock();
    });
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        hour = DateTime.now().hour % 12;
        minute = DateTime.now().minute;
        second = DateTime.now().second;
      });
    });
  }

  final List<String> _bgImages = [
    "https://e7.pngegg.com/pngimages/920/989/png-transparent-blue-sky-and-cloud-blurs-background-thumbnail.png",
    "https://img.freepik.com/free-photo/vivid-blurred-colorful-wallpaper-background_58702-3769.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRM2RGY6bI9aTIyvWPZEyFxAxlDlAkSL4my_zkJo7ZXjw6yKHMi_-7D3-9McvPyjTWt1_I&usqp=CAU",
    "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvcm0zNTEtYWRqLWJhY2tncm91bmQtMDEuanBn.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBvaKRar2f_nRPwATOJvM6ndjdjnVtO_xfWM0p-JMsDo1YyjNR0sqknMIGcjKTI7er-4g&usqp=CAU",
  ];

  int _selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    TextScaler textScaler = MediaQuery.of(context).textScaler;
    double h = size.height;
    double w = size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Clock Page"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            //Header
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                foregroundImage: NetworkImage(
                    "https://edug.in/panel/head_admin/School/school_head/first_photo/DEMO59167.jpg"),
              ),
              accountName: Text("MY ClockTimer Account"),
              accountEmail: Text("clocktimeryahuu@gmail.com"),
            ),
            //Options
            clockOptionTile(
              title: "Analog clock",
              val: _isAnalog,
              onChanged: (val) => setState(
                () => _isAnalog = !_isAnalog,
              ),
            ),
            clockOptionTile(
              title: "Strap clock",
              val: _isStrap,
              onChanged: (val) => setState(
                () => _isStrap = !_isStrap,
              ),
            ),
            clockOptionTile(
              title: "Digital clock",
              val: _isDigital,
              onChanged: (val) => setState(
                () => _isDigital = !_isDigital,
              ),
            ),
            clockOptionTile(
              title: "Clander ",
              val: _isCalender,
              onChanged: (val) => setState(
                () => _isCalender = !_isCalender,
              ),
            ),

            clockOptionTile(
              title: "Image",
              val: _image,
              onChanged: (val) => setState(
                () => _image = !_image,
              ),
            ),
            Visibility(
              visible: _image,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _bgImages
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            _selectedImage = _bgImages.indexOf(e);
                            setState(() {});
                          },
                          child: Container(
                            height: 80,
                            width: 80,
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: _bgImages.indexOf(e) == _selectedImage
                                  ? Border.all(color: Colors.grey)
                                  : null,
                              image: DecorationImage(
                                image: NetworkImage(e),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          image: _image
              ? DecorationImage(
                  image: NetworkImage(
                    _bgImages[_selectedImage],
                  ),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            //AnalogClock
            Visibility(
              visible: _isAnalog,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  //allDials
                  ...List.generate(
                    60,
                    (index) => Transform.rotate(
                      angle: index * (pi * 2) / 60,
                      child: Divider(
                        endIndent: index % 5 == 0
                            ? size.width * 0.88
                            : size.width * 0.9,
                        thickness: 2,
                        color: index % 5 == 0 ? Colors.black : Colors.black54,
                      ),
                    ),
                  ),

                  //hourHand
                  Transform.rotate(
                    angle: pi / 2,
                    child: Transform.rotate(
                      angle: hour * (pi * 2) / 12,
                      child: Divider(
                        indent: 50,
                        endIndent: size.width * 0.5 - 16,
                        color: Colors.black,
                        thickness: 4,
                      ),
                    ),
                  ),
                  //minuteHand
                  Transform.rotate(
                    angle: pi / 2,
                    child: Transform.rotate(
                      angle: minute * (pi * 2) / 60,
                      child: Divider(
                        indent: 30,
                        endIndent: size.width * 0.5 - 16,
                        color: Colors.black,
                        thickness: 2,
                      ),
                    ),
                  ),
                  //secondHand
                  Transform.rotate(
                    angle: pi / 2,
                    child: Transform.rotate(
                      angle: second * (pi * 2) / 60,
                      child: Divider(
                        indent: 20,
                        endIndent: size.width * 0.5 - 16,
                        color: Colors.red,
                        thickness: 2,
                      ),
                    ),
                  ),
                  //dot
                  const CircleAvatar(
                    radius: 10,
                  ),
                ],
              ),
            ),
            //StrapClock
            Visibility(
              visible: _isStrap,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  //HourStrap
                  Transform.scale(
                    scale: 5,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      value: (d.hour % 12) / 12,
                    ),
                  ),
                  //MinuteStrap
                  Transform.scale(
                    scale: 4,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      value: d.minute / 60,
                    ),
                  ),
                  //SecondStrap
                  Transform.scale(
                    scale: 3,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      value: d.second / 60,
                    ),
                  ),
                ],
              ),
            ),
//DigitalClock
            Visibility(
              visible: _isDigital,
              child: Center(
                child: Container(
                  height: size.height * 0.2,
                  width: size.width * 0.78,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(w * 0.03),
                    color: Colors.blue.shade100,
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 8,
                        blurRadius: 22,
                        offset: const Offset(-5, -2),
                        color: Colors.blue.shade100,
                      ),
                      BoxShadow(
                        spreadRadius: 10,
                        blurRadius: 30,
                        offset: const Offset(10, 2),
                        color: Colors.blue.shade200,
                      ),
                      BoxShadow(
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset: const Offset(-10, 10),
                        color: Colors.blue.shade100,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                hour.toString().padLeft(2, '0'),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Text(
                                ":",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                minute.toString().padLeft(2, '0'),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Text(
                                ":",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text(
                                    "PM",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Text(
                                    second.toString().padLeft(2, '0'),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${month[d.month - 1]}, ${weekday[d.weekday - 1]} ${d.day.toString().padLeft(2, '0')}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
//Calander
            Visibility(
              visible: _isCalender,
              child: Container(
                height: 90,
                child: CalenderPicker(
                  DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.blue,
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    // New date selected
                    // setState(() {
                    //   _selectedValue = date;
                    // });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
