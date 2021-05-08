import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class HeaderListModel {
  final String title;
  final String subtitle;
  final String imageUrl;
  final Function() onTap;

  HeaderListModel(
    this.title,
    this.subtitle,
    this.imageUrl,
    this.onTap,
  );
}

class HeaderList extends StatelessWidget {
  final String title;
  final String titleImageUrl;
  final List<HeaderListModel> items;

  const HeaderList(
    this.title,
    this.titleImageUrl,
    this.items, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length + 1,
        itemBuilder: (context, i) {
          if (i == 0) {
            return Header(title, titleImageUrl);
          }
          var item = items[i - 1];
          return buildListTile(item.title, item.subtitle, item.imageUrl, item.onTap);
        },
      ),
    );
  }

  ListTile buildListTile(String title, String subtitle, String imageUrl, Function() onTap) {
    return ListTile(
      leading: SizedBox(
        height: 56.0,
        width: 56.0,
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: imageUrl,
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }
}

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
