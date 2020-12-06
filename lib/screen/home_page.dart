import 'package:flutter/material.dart';
import 'package:unsplash_app/json/cards.dart';
import 'package:unsplash_app/screen/image_details.dart';
import 'package:unsplash_app/services/services.dart';
import 'package:unsplash_app/services/unsplash_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UnsplashCard> cards = [];
  bool loading;

  @override
  void initState() {
    super.initState();
    loading = true;
    Services.getCards().then((list) {
      setState(() {
        cards = list;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(loading ? 'Loading...' : 'Unsplash'),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: cards.length,
          itemBuilder: (context, index) {
            UnsplashCard card = cards[index];
            return _Image(card: card);
          },
        ),
      ),
    );
  }
}

class _Image extends StatefulWidget {
  const _Image({
    Key key,
    @required this.card,
  }) : super(key: key);

  final UnsplashCard card;

  @override
  _ImageState createState() => _ImageState();
}

class _ImageState extends State<_Image> with SingleTickerProviderStateMixin {
  static const _userNameTextStyle = TextStyle(
    fontSize: 18,
    color: Colors.white70,
    fontWeight: FontWeight.w500,
  );
  static const _descriptionTextStyle = TextStyle(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.w200,
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      vsync: this,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 100),
        child: Card(
          margin: EdgeInsets.all(8),
          clipBehavior: Clip.antiAlias,
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageDetailsPage(
                  card: widget.card,
                ),
              ),
            ),
            child: Stack(
              children: [
                Hero(
                  tag: widget.card.toString(),
                  child: UnsplashImage(url: widget.card.urls.regular),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black54],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0).copyWith(top: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.card.user.username,
                              style: _userNameTextStyle),
                          if (widget.card.altDescription != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Text(
                                widget.card.altDescription,
                                style: _descriptionTextStyle,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

    // return Padding(padding: EdgeInsets.all(3.0),
    //   child: Container(
    //     child: FittedBox(
    //       child: Material(
    //         color: Colors.grey[200],
    //         elevation: 14.0,
    //         shadowColor: Colors.grey[500],
    //         child: Container(
    //           decoration:  BoxDecoration(
    //             borderRadius:  BorderRadius.all(Radius.circular(1.0)),
    //             gradient:  LinearGradient(
    //                 colors: [Colors.grey, Colors.black54]
    //             ),
    //           ),
    //           width: 200,
    //           height: 50,
    //           child: Row(
    //             children: [
    //               Padding(
    //                 padding: EdgeInsets.all(1.0),
    //                 child: Center(
    //                   child: Container(
    //                     width: 80,
    //                     child: FlatButton(
    //                       onPressed: () {
    //                         Route route = MaterialPageRoute(builder: (context) => Page2(full: card));
    //                         Navigator.push(context, route);
    //                       },
    //                       child: UnsplashImage(url: card.urls.regular),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(width: 5.0,),
    //               Expanded(
    //                 child: Padding(
    //                   padding: EdgeInsets.all(2.0),
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text(card?.altDescription ?? '', style: TextStyle(fontSize: 7, color: Colors.white), textAlign: TextAlign.center),
    //                       Text(card.user.username, style: TextStyle(fontSize: 7, color: Colors.white54, fontWeight: FontWeight.w700),),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
