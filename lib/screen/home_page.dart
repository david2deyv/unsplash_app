import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
        backgroundColor: Colors.deepPurple,
        title: Text(loading ? 'Loading...' : 'Unsplash'),
        centerTitle: true,
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          UnsplashCard card = cards[index];
          return _Image(card: card);
        },
        staggeredTileBuilder: (index) => StaggeredTile.count(2, index.isEven ? 2 : 4),
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
    fontSize: 14,
    color: Colors.white70,
    fontWeight: FontWeight.w500,
  );
  static const _descriptionTextStyle = TextStyle(
    fontSize: 12,
    color: Colors.white,
    fontWeight: FontWeight.w200,
  );

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 150),
      child: Card(
        margin: EdgeInsets.all(6),
        clipBehavior: Clip.antiAlias,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: 0,
                child: Hero(
                  tag: widget.card.toString(),
                  child: UnsplashImage(
                    url: widget.card.urls.regular,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black87],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0).copyWith(top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.card.user.username, style: _userNameTextStyle),
                        if (widget.card.altDescription != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
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
    );
  }
}
