import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final dynamic route;
  final String imageTag;
  final int crossAxisCount;

  MainCard(this.title, this.description, this.image, this.route, this.imageTag,
      [this.crossAxisCount = 1]);

  @override
  Widget build(BuildContext context) {
    if (imageTag != "Технічні бюлетені" &&
        imageTag != "Спеціальний інструмент" &&
        imageTag != "Коди красок") {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 16,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, route);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    imageTagCheck(imageTag, image, context, crossAxisCount),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: descriptionCheck(title, description),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 16,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, route);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    title.substring(11),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}

List<Widget> descriptionCheck(title, description) {
  if (description != null) {
    return [
      Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      Text(description),
    ];
  } else {
    return [
      Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
    ];
  }
}

Widget imageTagCheck(imageTag, image, context, crossAxisCount) {
  if (imageTag != null) {
    return Hero(
      tag: imageTag,
      child: Material(
        child: Ink.image(
          height: ((MediaQuery.of(context).size.width - 20) / 16 * 9) /
              crossAxisCount,
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  } else {
    return Ink.image(
      height:
          ((MediaQuery.of(context).size.width - 20) / 16 * 9) / crossAxisCount,
      image: AssetImage(image),
      fit: BoxFit.cover,
    );
  }
}
