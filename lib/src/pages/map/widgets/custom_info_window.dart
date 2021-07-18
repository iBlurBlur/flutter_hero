import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomInfoWindow extends StatefulWidget {
  final LatLng? position;
  final double top;
  final VoidCallback navigator;

  CustomInfoWindow(this.position, {required this.top, required this.navigator});

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
                  _buildNavigatorButton(),
                  _buildCallButton(),
                ],
              ),
            ),
    );
  }

  Container _buildAvatar() {
    final image =
        'https://static.highsnobiety.com/thumbor/Z6PUedX0SRIzwFNFqMandGXHyDk=/1600x1067/static.highsnobiety.com/wp-content/uploads/2020/12/27130155/loewe-totoro-collaboration-main.jpg';
    final tag = 1234;
    return Container(
      width: 50,
      height: 50,
      child: Hero(
        tag: tag,
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 500),
              pageBuilder: (_, __, ___) => DetailPage(tag, image: image),
            ),
          ),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              image,
            ),
          ),
        ),
      ),
    );
  }

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
                'order: 4090-5245-33',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              Text(
                'Location: ${widget.position!.latitude.toStringAsFixed(4)}, ${widget.position!.longitude.toStringAsFixed(4)}',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );

  IconButton _buildNavigatorButton() => IconButton(
        onPressed: widget.navigator,
        icon: FaIcon(
          FontAwesomeIcons.locationArrow,
          color: Colors.redAccent,
          size: 25,
        ),
      );

  IconButton _buildCallButton() => IconButton(
        onPressed: () => launch('tel:1150'),
        icon: FaIcon(
          FontAwesomeIcons.phone,
          color: Colors.green,
          size: 25,
        ),
      );
}

class DetailPage extends StatelessWidget {
  final int tag;
  final String image;

  const DetailPage(this.tag, {required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Rider009'),
              background: Hero(
                tag: tag,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SelectableText.rich(
                TextSpan(
                  text: 'Lorem Ipsum',
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          " is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                      style: TextStyle(
                        height: 1.5,
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text:
                      'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.',
                      style: TextStyle(
                        height: 1.5,
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text:
                      'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.',
                      style: TextStyle(
                        height: 1.5,
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
