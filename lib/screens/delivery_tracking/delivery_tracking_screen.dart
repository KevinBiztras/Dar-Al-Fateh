import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_project_structure/config/theme.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/main.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../constants/arguments_map.dart';

class DeliveryTrackingScreen extends StatefulWidget {
  Map<String,dynamic>? args;
  DeliveryTrackingScreen(this.args,{Key? key}) : super(key: key);

  @override
  State<DeliveryTrackingScreen> createState() => _DeliveryTrackingScreenState();
}

class _DeliveryTrackingScreenState extends State<DeliveryTrackingScreen> {
  AppLocalizations? localization;
  final Completer<GoogleMapController> _controller = Completer();
  static LatLng sourceLocation = const LatLng(37.33500926, -122.03272188);
  static LatLng destination = const LatLng(37.33429383, -122.06600055);
  List<LatLng> polylineCoordinates = [];
  LatLng? deliveryBoyLocation;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor deliveryBoyIcon = BitmapDescriptor.defaultMarker;

 @override
  void initState() {
   setCustomMarkerIcon();
   fetchCoordinates();
    startTracking();
    super.initState();
  }


  @override
  void didChangeDependencies() {
    localization = AppLocalizations.of(context);
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localization?.translate(AppStringConstant.trackOrder) ?? '',
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: destination,
          zoom: 13.5,
        ),
        markers: {
           Marker(
            markerId: const MarkerId("source"),
            position: sourceLocation,
            icon: sourceIcon,
          ),
          Marker(
            icon: destinationIcon,
            markerId: const MarkerId("destination"),
            position: destination,
          ),
          if(deliveryBoyLocation !=null)
          Marker(
            icon: deliveryBoyIcon,
            markerId: const MarkerId("deliveryboy"),
            position: deliveryBoyLocation!,
          ),
        },
        onMapCreated: (mapController) {
          _controller.complete(mapController);
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId("route"),
            points: polylineCoordinates,
            color: MobikulTheme.clientAccentColor,
            width: 8,
          ),
        },
      ),
    );
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints(apiKey:"AIzaSyDYwUZZe8puCOem7I5WR3gkuU7c9F3Zciw" );
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        request:PolylineRequest(
          origin: PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
          destination:   PointLatLng(destination.latitude, destination.longitude),
          mode: TravelMode.driving,
          // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")],
        ),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
            (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "lib/assets/images/source_pin.png")
        .then(
          (icon) {
        sourceIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "lib/assets/images/destination_pin.png")
        .then(
          (icon) {
        destinationIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "lib/assets/images/delivery_pin.png")
        .then(
          (icon) {
        deliveryBoyIcon = icon;
      },
    );
  }

  fetchCoordinates() async{
    List<Location> locations = await locationFromAddress(widget.args?[shippingAddressKey]);
    print("LOCATIONS-->${locations}");
    if(locations.isNotEmpty){
      Location location = locations.first;
      destination = LatLng(location.latitude,location.longitude);
    }

    String warehouseAddress = widget.args?[wareHouseAddress]??'';
    String wareHouseLatitude = widget.args?[wareHouseAddressLat]??'';
    String wareHouseLongitude = widget.args?[wareHouseAddressLong]??'';

    if(wareHouseLatitude.isNotEmpty && wareHouseLongitude.isNotEmpty){
      sourceLocation = LatLng(double.parse(wareHouseLatitude),double.parse(wareHouseLongitude));
    }else{
      List<Location> locations = await locationFromAddress(warehouseAddress);
      if(locations.isNotEmpty){
        Location location = locations.first;
        sourceLocation = LatLng(location.latitude,location.longitude);
      }
    }
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLng(destination),
    );
    if(mounted) {
      getPolyPoints();
      setState(() {});
    }
  }


  void startTracking() async {
      // secondaryDatabase.ref().child('DeliveryApp/locationData/${widget.args?[deliveryBoyIdKey]}').onValue.listen((event) {
      //   print("EVENTDATA-->${event.snapshot.value}");
      //   if(event.snapshot.value!=null){
      //     Map<dynamic,dynamic> data = event.snapshot.value as Map<dynamic,dynamic>;
      //     LatLng latLng = LatLng(data['latitude'],data['longitude']);
      //     print("LATLNG-->${latLng}");
      //     deliveryBoyLocation = latLng;
      //   }
      // });

      if(mounted){
        setState(() {});
      }
      Future.delayed(const Duration(seconds: 2), () {
        startTracking();
      });

  }

}
