import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageHeader extends StatelessWidget {
  final String title;
  final String imageUrl;

  const ImageHeader(
    this.title,
    this.imageUrl, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Stack(
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
            Positioned(
              top: 30,
              left: 0,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
