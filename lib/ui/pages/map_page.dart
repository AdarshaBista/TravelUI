import 'package:flutter/material.dart';

import 'package:travel_ui/api_keys.dart';
import 'package:travel_ui/data/data.dart';
import 'package:travel_ui/ui/styles/index.dart';

import 'package:latlong/latlong.dart';

import 'package:provider/provider.dart';
import 'package:travel_ui/models/place.dart';
import 'package:travel_ui/providers/place_provider.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:travel_ui/ui/widgets/map_page/place_card.dart';

class MapPage extends StatefulWidget {
  final LatLng center;

  const MapPage({
    this.center,
  });

  @override
  MapPageState createState() {
    return MapPageState();
  }
}

class MapPageState extends State<MapPage> with TickerProviderStateMixin {
  MapController _mapController;
  bool _isPlaceVisible = true;
  int _mapStyleIndex = 0;
  final List<String> _mapStyles = [
    'mapbox.satellite',
    'mapbox.dark',
    'mapbox.light',
  ];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  void _animateMapTo(LatLng destLocation) {
    final destZoom = 16.0;
    final _latTween = Tween<double>(begin: _mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(begin: _mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);

    AnimationController animController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    Animation<double> animation = CurvedAnimation(parent: animController, curve: Curves.fastOutSlowIn);

    animController.addListener(() {
      _mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)), _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animController.dispose();
      } else if (status == AnimationStatus.dismissed) {
        animController.dispose();
      }
    });
    animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFab(context),
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          zoom: 15.0,
          center: widget.center == null ? LatLng(dummyPlaces[0].lat, dummyPlaces[0].lng) : widget.center,
          onTap: (LatLng tapPosition) {
            _animateMapTo(tapPosition);
          },
        ),
        layers: [
          _buildTiles(),
          _buildMarkers(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          "Map",
          style: mediumTextStyle.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  UnicornDialer _buildFab(BuildContext context) {
    return UnicornDialer(
      backgroundColor: Colors.black26,
      parentButtonBackground: Theme.of(context).primaryColor,
      orientation: UnicornOrientation.VERTICAL,
      parentButton: Icon(Icons.layers),
      finalButtonIcon: Icon(Icons.close),
      childButtons: <UnicornButton>[
        UnicornButton(
          hasLabel: true,
          labelText: "Map Style",
          currentButton: FloatingActionButton(
            heroTag: "mapStyle",
            backgroundColor: Colors.orange,
            mini: true,
            child: Icon(Icons.style),
            onPressed: () {
              setState(() {
                _mapStyleIndex++;
              });
            },
          ),
        ),
        UnicornButton(
          hasLabel: true,
          labelText: "Places",
          currentButton: FloatingActionButton(
            heroTag: "places",
            backgroundColor: Colors.deepPurple,
            mini: true,
            child: Icon(Icons.place),
            onPressed: () {
              setState(() {
                _isPlaceVisible = !_isPlaceVisible;
              });
            },
          ),
        ),
      ],
    );
  }

  TileLayerOptions _buildTiles() {
    return TileLayerOptions(
      keepBuffer: 8,
      urlTemplate: "https://api.tiles.mapbox.com/v4/"
          "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
      additionalOptions: {
        'accessToken': MAPBOX_ACCESS_TOKEN,
        'id': _mapStyles[_mapStyleIndex % _mapStyles.length],
      },
    );
  }

  MarkerLayerOptions _buildMarkers() {
    final List<Place> allPlaces = Provider.of<PlaceProvider>(context).places;
    return MarkerLayerOptions(
      markers: [
        if (_isPlaceVisible)
          for (Place place in allPlaces)
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(place.lat, place.lng),
              builder: (BuildContext context) => IconButton(
                icon: Icon(Icons.place),
                color: Colors.redAccent,
                onPressed: () {
                  if (widget.center != null) return;
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return PlaceCard(place: place);
                    },
                  );
                },
              ),
            ),
      ],
    );
  }
}
