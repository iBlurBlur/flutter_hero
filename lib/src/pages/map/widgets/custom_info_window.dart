import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomInfoWindow extends StatefulWidget {
  final LatLng? position;
  final double top;

  CustomInfoWindow(this.position, this.top);

  @override
  State<StatefulWidget> createState() => CustomInfoWindowState();
}

class CustomInfoWindowState extends State<CustomInfoWindow> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: widget.position == null ? 0 : widget.top,
      right: 0,
      left: 0,
      duration: Duration(milliseconds: 500),
      child: widget.position == null
          ? SizedBox()
          : Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 20,
              offset: Offset.zero,
              color: Colors.grey.withOpacity(0.5),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildAvatar(),
            _buildInfo(),
            _buildCallButton(),
          ],
        ),
      ),
    );
  }

  Container _buildAvatar() => Container(
    width: 50,
    height: 50,
    child: CircleAvatar(
      backgroundImage: NetworkImage(
        'https://static.highsnobiety.com/thumbor/Z6PUedX0SRIzwFNFqMandGXHyDk=/1600x1067/static.highsnobiety.com/wp-content/uploads/2020/12/27130155/loewe-totoro-collaboration-main.jpg',
      ),
    ),
  );

  Expanded _buildInfo() => Expanded(
    child: Container(
      margin: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Cat Lover',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Latitude: ${widget.position?.latitude.toString()}',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          Text(
            'Longitude: ${widget.position?.longitude.toString()}',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );

  IconButton _buildCallButton() => IconButton(
    onPressed: () {},
    icon: FaIcon(
      FontAwesomeIcons.phone,
      color: Colors.green,
      size: 30,
    ),
  );
}