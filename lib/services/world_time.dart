import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime{
  late String location;
  late String time;
  late String flag ;
  late String url;
  late bool isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});


  Future <void> getTIme() async {
    try{
      Response response = await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);

      String dateTime = data["datetime"];
      String offset = data["utc_offset"].substring(1,3);

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }catch(e){
      time = "could not get time data";
    }
  }
}

