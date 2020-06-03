import 'package:flutter/material.dart';

import 'package:travel_ui/api_keys.dart';
import 'package:travel_ui/data/data.dart';
import 'package:travel_ui/ui/styles/index.dart';

import 'package:latlong/latlong.dart';

import 'package:provider/provider.dart';
import 'package:travel_ui/models/place.dart';
import 'package:travel_ui/providers/place_provider.dart';

import 'package:flutter_map/flutter_map.dart';
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

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  void _animateMapTo(LatLng destLocation, [double zoom = 12.0]) {
    final destZoom = zoom;
    final _latTween =
        Tween<double>(begin: _mapController.center.latitude, end: destLocation.latitude);
    final _lngTween =
        Tween<double>(begin: _mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);

    AnimationController animController =
        AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    Animation<double> animation =
        CurvedAnimation(parent: animController, curve: Curves.fastOutSlowIn);

    animController.addListener(() {
      _mapController.move(LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
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
          center: widget.center == null
              ? LatLng(dummyPlaces[0].lat, dummyPlaces[0].lng)
              : widget.center,
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

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(
        Icons.zoom_in,
        size: 24.0,
      ),
      onPressed: () {
        LatLng center =
            widget.center == null ? LatLng(dummyPlaces[0].lat, dummyPlaces[0].lng) : widget.center;
        _animateMapTo(center, 16.0);
      },
    );
  }

  TileLayerOptions _buildTiles() {
    return TileLayerOptions(
      tileProvider: NetworkTileProvider(),
      keepBuffer: 8,
      tileSize: 512,
      zoomOffset: -1,
      urlTemplate:
          "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}@2x?access_token={accessToken}",
      additionalOptions: {
        'accessToken': MAPBOX_ACCESS_TOKEN,
        'id': 'mapbox/satellite-v9',
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
