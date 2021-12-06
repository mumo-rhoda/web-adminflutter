import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/models/emegercies.dart';
import 'package:flutter_web_dashboard/models/users.dart';
import 'dart:ui' as ui;
import 'package:google_maps/google_maps.dart';





Widget _mMapWidget({@required Emergencies emergency, @required Users user}) {



  String htmlId = DateTime.now().microsecondsSinceEpoch.toString();
  final key = GlobalKey();



  //ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
    final myLatlng = LatLng(-1.2198906, 36.889212999999984);


    final mapOptions = MapOptions()
      ..zoom = 13
      ..center = myLatlng;

    final elem = DivElement()
      ..id = htmlId
      ..style.width = "100%"
      ..style.height = "100%"
      ..style.border = 'none';

    final map = GMap(elem, mapOptions);





      if(emergency.locationLatLng != null){

        final myLatlng = LatLng(emergency.locationLatLng.latitude, emergency.locationLatLng.longitude);
        final marker = Marker(
            MarkerOptions()
              ..position = myLatlng
              ..map = map
              ..title = '${emergency.ReportType}/${emergency.Description}'
              ..label = ''
              ..icon = "assets/images/emergency.png"
        );




        var contentString = '<div id="content">' +
            '<div id="siteNotice">' +
            '</div>' +
            '<h1 id="firstHeading" class="firstHeading">${emergency.ReportType}</h1>' +
            '<div id="bodyContent">' +
            '<p><b></b>name: ${user.fullname} <b></b>' +
            '</p>'+
            '<p>Phone: ${user.phonenumber} '+
            '</p>'+
            '</p>'+
            '<p>Status: ${emergency.ReportStatus} '+
            '</p>'+
            '</p>'+
            '<p>Date: ${emergency.dateTime} '+
            '</p>'
            '<p>Description: ${emergency.ReportStatus} '+
            '</p>';

        final infoWindow = InfoWindow(InfoWindowOptions()..content = contentString);
        marker.onClick.listen((event) => infoWindow.open(map, marker));







        final latlngHQ = LatLng(-1.3235, 36.8265);
        final markerHQ = Marker(
            MarkerOptions()
              ..position = latlngHQ
              ..map = map
              ..title = 'Red Cross HQ'
              ..label = ''
              ..icon = "assets/images/redcross.jpg"
        );




        var contentStringHQ = '<div id="content">' +
            '<div id="siteNotice">' +
            '</div>' +
            '<h1 id="firstHeading" class="firstHeading">Red Cross HQ</h1>' +
            '<div id="bodyContent">' +
            '<p><b></b>Nairobi head offices<b></b>' +
            '</p>';

        final infoWindowHQ = InfoWindow(InfoWindowOptions()..content = contentStringHQ);
        markerHQ.onClick.listen((event) => infoWindowHQ.open(map, markerHQ));
        marker.onClick.listen((event) => infoWindowHQ.open(map, markerHQ));
      }



    return elem;
  });

  return HtmlElementView(viewType: htmlId, key: key,);
}



class MapsWidget extends StatelessWidget {
  Emergencies emergency;
  Users user;


   MapsWidget({key, this.emergency, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _mMapWidget(emergency: emergency, user: user),
    );
  }
}
