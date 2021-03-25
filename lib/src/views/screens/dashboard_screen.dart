import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:harlequinsos/src/core/data_connection_checker.dart';
import 'package:harlequinsos/src/models/dasboard_model.dart';
import 'package:harlequinsos/src/services/dashboard_service.dart';
import 'package:harlequinsos/src/views/widgets/app_button.dart';
import 'package:harlequinsos/src/views/widgets/service.dart';
import 'package:harlequinsos/src/views/widgets/transparent_status_bar.dart';

import 'file:///C:/Users/user/Documents/Flutter/harlequin_sos/lib/src/core/constants.dart';
import 'file:///C:/Users/user/Documents/Flutter/harlequin_sos/lib/src/core/images.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  callApi(String clientLatitude, String clientLongitude, String clientSituation,
      String clientLga) async {
//    await Get.find<DataConnectionCheckerService>().checkConnection();
    await DataConnectionCheckerService().checkConnection();
    Post post = Post(
      client_id: 'client_id',
      client_latitude: clientLatitude,
      client_longitude: clientLongitude,
      client_situation: clientSituation,
      client_lga: clientLga,
      upload_use: "create",
    );
    createPost(post).then((response) {
      if (response.statusCode > 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: ${response.body}')));

        print(response.body);
      } else if (response.statusCode == 1) {
        Dialog show = Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(24),
            height: MediaQuery.of(context).size.height / 5,
            color: Colors.white,
            child: Column(
              children: [
                Text("Emergency case successfully uploaded"),
                kMediumVerticalSpacing,
                AppButton(onPressed: () => Navigator.pop(context), label: "Ok"),
              ],
            ),
          ),
        );
        showDialog(context: context, builder: (BuildContext context) => show);
      } else {
        Dialog show = Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(24),
            height: MediaQuery.of(context).size.height / 5,
            color: Colors.white,
            child: Column(
              children: [
                Text("Emergency case failled to upload"),
                kMediumVerticalSpacing,
                AppButton(onPressed: () => Navigator.pop(context), label: "Ok"),
              ],
            ),
          ),
        );
        showDialog(context: context, builder: (BuildContext context) => show);
        print(response.statusCode.toString());
        print(response.body);
      }
    }).catchError((error) {
      print('error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return TransparentStatusbar(
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(' Harliquin SOS', style: kHeading2TextStyle),
              actions: [
                Icon(
                  Icons.menu,
                  color: kWhiteColor,
                ),
              ],
            ),
            body:
//                callApi();
//                Text('${snapshot.data.clientSituation}');
                Center(
              child: GridView.count(

                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 2,
                  // Generate 100 widgets that display their index in the List.
                  children: [
                    GestureDetector(
                        onTap: () => {
                              callApi(
                                _currentPosition.latitude.toString(),
                                _currentPosition.longitude.toString(),
                                "Highway Kiddnaping",
                                "lag",
                              ),

//                          print('${_currentPosition.latitude.toString()}')
                            },
                        child: Service(
                            img: school, label: "Highway\n Kidnapping")),
                    GestureDetector(
                        onTap: () => {
                              callApi(
                                _currentPosition.latitude.toString(),
                                _currentPosition.longitude.toString(),
                                "School Premises Kidnapping",
                                "lag",
                              ),

//                          print('${_currentPosition.latitude.toString()}')
                            },
                        child: Service(
                            img: school,
                            label: "School Premises \n Kidnapping")),
                    GestureDetector(
                        onTap: () => {
                              callApi(
                                _currentPosition.latitude.toString(),
                                _currentPosition.longitude.toString(),
                                "Community Invasion",
                                "lag",
                              ),

//                          print('${_currentPosition.latitude.toString()}')
                            },
                        child:
                            Service(img: theft, label: "Community\n Invasion")),
                    GestureDetector(
                        onTap: () => {
                              callApi(
                                _currentPosition.latitude.toString(),
                                _currentPosition.longitude.toString(),
                                "Herdsmen Attack",
                                "lag",
                              ),

//                          print('${_currentPosition.latitude.toString()}')
                            },
                        child:
                            Service(img: school, label: "Herdsmen\n Attack")),
                    GestureDetector(
                        onTap: () => {
                              callApi(
                                _currentPosition.latitude.toString(),
                                _currentPosition.longitude.toString(),
                                "Armed Robbery",
                                "lag",
                              ),

//                          print('${_currentPosition.latitude.toString()}')
                            },
                        child: Service(img: bandit, label: "Armed\n Robbery")),
                  ]),
            )),
      ),
    );
  }
}