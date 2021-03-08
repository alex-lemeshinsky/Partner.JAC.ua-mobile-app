import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GridCard extends StatelessWidget {
  final String title;
  final String image;
  final dynamic route;
  final _url = 'https://flutter.dev';

  GridCard(this.title, this.image, this.route);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 16,
        child: InkWell(
          onTap: () {
            launch(
              _url,
              forceWebView: true,
              enableJavaScript: true,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Ink.image(
                    height: 130,
                    image: AssetImage(image),
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
