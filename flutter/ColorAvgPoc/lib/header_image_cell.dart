import 'package:ColorAvgPoc/image_util.dart';
import 'package:flutter/material.dart';

class HeaderImageCell extends StatelessWidget {
  final String imageName;
  final String text =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

  const HeaderImageCell({Key key, this.imageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imgAsset = AssetImage('assets/$imageName');
    final colorFuture = ImageUtil().imageAverageColor(context, imgAsset);

    return Card(
      margin:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image(image: imgAsset),
          FutureBuilder<Color>(
              future: colorFuture,
              builder: (context, snapshot) {
                final color =
                    snapshot.hasData ? snapshot.data : Colors.transparent;
                return Column(
                  children: [
                    Container(
                      height: 36,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                            color.withAlpha(0),
                            color,
                          ])),
                    ),
                    Container(height: 28, color: color),
                  ],
                );
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
              maxLines: 2,
            ),
          )
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      clipBehavior: Clip.antiAlias,
    );
  }
}
