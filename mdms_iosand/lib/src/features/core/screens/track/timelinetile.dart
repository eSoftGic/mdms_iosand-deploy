// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart' show AppBar, BorderRadius, BoxDecoration, BuildContext, Card, Colors, Column, Container, CrossAxisAlignment, EdgeInsets, Flexible, ListView, MaterialApp, MediaQuery, Padding, Positioned, Row, Scaffold, Size, SizedBox, Stack, StatelessWidget, Text, TextStyle, Widget;
import 'dart:math';

TextStyle style = const TextStyle(color: Colors.white);

class MyTimeLine extends StatelessWidget {
  const MyTimeLine({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timeline',
      home: TimelineComponent(title: 'Timeline'),
    );
  }
}

class TimelineComponent extends StatelessWidget {
  TimelineComponent({super.key, this.title});
  final String? title;

  final List<Events> listOfEvents = [
    Events(time: "12.5.23 - 10:00 am", eventName: "Order Prepared", description: "Ord. No. 5"),
    Events(time: "12.5.23 - 16:00 pm", eventName: "Order Approved", description: "By XYZ"),
    Events(time: "12pm", eventName: "Bill Prepared", description: "Main Room"),
    Events(time: "12pm", eventName: "Bill Approved", description: "Main Room"),
    Events(time: "12pm", eventName: "Finance Approved", description: "Main Room"),
    Events(time: "12pm", eventName: "Logistics Approved", description: "Main Room"),
    Events(time: "9 - 11am", eventName: "Finish Home Screen", description: "Web App"),
  ];

  //final List<Color> listOfColors = [kPurpleColor, kGreenColor, kRedColor];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Random random = Random();
    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /*Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 10,
                left: 30,
                child: Row(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text("Party Name", style: style.copyWith(fontSize: 25.0)),
                        Text("Order No.".toUpperCase(), style: style.copyWith(fontSize: 12.0)),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),*/
          Card(
            elevation: 10,
            child: Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text("Party Name", style: TextStyle(fontSize: 25.0)),
                    Text("Order No.".toUpperCase(), style: const TextStyle(fontSize: 12.0)),
                  ],
                ),
              ),
            ]),
          ),
          Flexible(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: listOfEvents.length,
                itemBuilder: (context, i) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(40),
                        child: Row(
                          children: [
                            SizedBox(width: size.width * 0.1),
                            SizedBox(
                              width: size.width * 0.2,
                              child: Text(listOfEvents[i].time),
                            ),
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(listOfEvents[i].eventName),
                                  Text(
                                    listOfEvents[i].description,
                                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        left: 50,
                        child: Container(
                          height: size.height * 0.7,
                          width: 1.0,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Container(
                            height: 20.0,
                            width: 20.0,
                            decoration: BoxDecoration(
                              color: Colors.orange, // listOfColors[random.nextInt(3)],
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class Events {
  final String time;
  final String eventName;
  final String description;
  Events({required this.time, required this.eventName, required this.description});
}