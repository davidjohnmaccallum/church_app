import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class Header extends StatelessWidget {
  final String title;
  final String imageUrl;

  const Header(
    this.title,
    this.imageUrl, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.cover,
              clipBehavior: Clip.hardEdge,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: imageUrl,
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 60,
            ),
          )
        ],
      ),
    );
  }
}
