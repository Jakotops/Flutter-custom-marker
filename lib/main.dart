import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter map',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BitmapDescriptor customIcon;
  late Set<Marker> markers;
  @override
  void initState() {
    super.initState();
    markers = Set.from([]);
  }

  createMarker(context) async {
  if (customIcon == null) {
    final ByteData data = await rootBundle.load('assets/fd.png');
    final Uint8List bytes = data.buffer.asUint8List();
    setState(() {
      customIcon = BitmapDescriptor.fromBytes(bytes);
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    createMarker(context);
    return Scaffold(
      body: GoogleMap(
        markers: markers,
        onTap: (pos) {
          print(pos);
          Marker m =
              Marker(markerId: MarkerId('1'), icon: customIcon, position: pos);
          setState(() {
            markers.add(m);
          });
        },
        onMapCreated: (GoogleMapController controller) {},
        initialCameraPosition:
            CameraPosition(target: LatLng(36.98, -121.99), zoom: 18),
      ),
    );
  }
}
