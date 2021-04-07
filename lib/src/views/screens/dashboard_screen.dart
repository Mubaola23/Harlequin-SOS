import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:harlequinsos/src/core/constants.dart';
import 'package:harlequinsos/src/core/data_connection_checker.dart';
import 'package:harlequinsos/src/models/dasboard_model.dart';
import 'package:harlequinsos/src/services/dashboard_service.dart';
import 'package:harlequinsos/src/views/widgets/app_button.dart';
import 'package:harlequinsos/src/views/widgets/service.dart';
import 'package:harlequinsos/src/views/widgets/transparent_status_bar.dart';

import '../../core/constants.dart';
import '../../core/images.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with WidgetsBindingObserver {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;
  bool isLoading = false;
  bool isTimer = false;

  startTimeout([int milliseconds]) {
    isTimer = true;
    var timer = Timer.periodic(Duration(seconds: 5), (time) {
      isTimer = false;
      time.cancel();
    });
  }

  @override
  void initState() {
    _getCurrentLocation();
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('$state');
    switch (state) {
      case AppLifecycleState.resumed:
        _keepAlive(false);
        Navigator.pop(context);

        print('$state');
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _keepAlive(false); //
        print(state); // onservatively set a timer on all three
        break;

      default:
        _keepAlive(false);
    }
  }

  static const _inactivityTimeout = Duration(seconds: 5);
  Timer _keepAliveTimer;

  void _keepAlive(bool visible) {
    _keepAliveTimer?.cancel();
    if (visible) {
      _keepAliveTimer = null;
    } else {
      _keepAliveTimer = Timer(
        _inactivityTimeout,
        () {},
      );
    }
  }

  void startKeepAlive() {
    assert(_keepAliveTimer == null);
    if (startTimeout() == 5) {
      _keepAlive(false);
    } else {
      _keepAlive(true);
    }

    WidgetsBinding.instance.removeObserver(this);
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
            "${place.administrativeArea}, ${place.name},${place.country}";
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
      } else if (response.statusCode == 200) {
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
                Text("Emergency situation has been successfully reported"),
                kMediumVerticalSpacing,
                AppButton(
                    onPressed: () => Navigator.pop(context),
                    func: () {
                      startKeepAlive();
                    },
                    label: "Ok"),
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
              backgroundColor: kPrimaryColor,
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
                        onTap: () =>
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: Duration(seconds: 5),
                                backgroundColor: Colors.red.shade700,
                                content: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 24.0),
                                  child:
                                      Text('Double tap to report a situation'),
                                ))),
                        onDoubleTap: () => {
                              callApi(
                                _currentPosition.latitude.toString(),
                                _currentPosition.longitude.toString(),
                                "Highway Kiddnaping",
                                _currentAddress,
                              ),

//                          print('${_currentPosition.latitude.toString()}')
                            },
                        child: Service(
                            img: school, label: "Highway\n Kidnapping")),
                    GestureDetector(
                        onTap: () =>
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red.shade700,
                                duration: Duration(seconds: 5),
                                content: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 24.0),
                                  child:
                                      Text('Double tap to report a situation'),
                                ))),
                        onDoubleTap: () => {
                              callApi(
                                _currentPosition.latitude.toString(),
                                _currentPosition.longitude.toString(),
                                "School Premises Kidnapping",
                                _currentAddress,
                              ),

//                          print('${_currentPosition.latitude.toString()}')
                            },
                        child: Service(
                            img: school,
                            label: "School Premises \n Kidnapping")),
                    GestureDetector(
                        onTap: () =>
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red.shade700,
                                duration: Duration(seconds: 5),
                                content: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 24.0),
                                  child:
                                      Text('Double tap to report a situation'),
                                ))),
                        onDoubleTap: () => {
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
                        onTap: () =>
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red.shade700,
                                duration: Duration(seconds: 5),
                                content: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 24.0),
                                  child:
                                      Text('Double tap to report a situation'),
                                ))),
                        onDoubleTap: () => {
                              callApi(
                                _currentPosition.latitude.toString(),
                                _currentPosition.longitude.toString(),
                                "Herdsmen Attack",
                                _currentAddress,
                              ),
                              print(_currentAddress),
                            },
                        child:
                            Service(img: school, label: "Herdsmen\n Attack")),
                    GestureDetector(
                        onTap: () =>
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red.shade700,
                                duration: Duration(seconds: 5),
                                content: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 24.0),
                                  child:
                                      Text('Double tap to report a situation'),
                                ))),
                        onDoubleTap: () => {
                              callApi(
                                _currentPosition.latitude.toString(),
                                _currentPosition.longitude.toString(),
                                "Armed Robbery",
                                _currentAddress,
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
