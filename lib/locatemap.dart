import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_signup_screen/locservice.dart';
import 'package:location/location.dart';
import 'package:login_signup_screen/suggestion.dart';

class GoogleMapScreen extends StatefulWidget {
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  Set<Marker> _markers = Set<Marker>();
  TextEditingController _searchController = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();
  void _onMapCreated(GoogleMapController controller){
    controller.setMapStyle(Utils.mapStyle);
  }

  static final CameraPosition _defalt = CameraPosition(
    target: LatLng(12.917137, 77.622791),
    zoom: 15,
  );

  @override
  void initState(){
    super.initState();

    _setMarker(LatLng(12.917137, 77.622791));
  }

  void _setMarker(LatLng point){
    setState((){
      _markers.add(Marker(markerId: MarkerId('id-1'), position: point),);
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            visualDensity: VisualDensity.adaptivePlatformDensity
        ),
        home: Scaffold(
      appBar: AppBar(
        title: Text('Find Location Status')
      ),
      body: Column(
    children: [
      Row(children: [
        Expanded(child: TextFormField(
          controller: _searchController,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(hintText: 'Search by City'),
          onChanged: (value){
            print(value);
          },
        )),
        IconButton(onPressed: () async {
          var place = await LocationService().getPlace(_searchController.text);
          _goToPlace(place);
        }, icon: Icon(Icons.search),),
      ],),

    Expanded(
    child: GoogleMap(
        markers: _markers,
        onMapCreated: _onMapCreated,
        initialCameraPosition:  _defalt,
      ),
    )])

          ,
          floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  )
              ),
              tooltip: 'Google Map',
              child: Icon(Icons.add)
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ));


  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat,  lng),  zoom: 15),
    ),);

    _setMarker(LatLng(lat, lng));

  }

}





class Utils {
  static String mapStyle = '''
  [
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]
  ''';
}