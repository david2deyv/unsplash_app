import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:unsplash_app/json/cards.dart';
import 'package:unsplash_app/provider/unsplash_provider.dart';
import 'package:unsplash_app/screen/image_details.dart';
import 'package:unsplash_app/widgets/unsplash_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UnsplashProvider>(
      builder: (context, provider, _) {
        Widget body = SizedBox.shrink();
        final state = provider.state;
        if (state is UnsplashStateLoading) {
          body = Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
            ),
          );
        } else if (state is UnsplashStateError) {
          body = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text(state.errorMessage)),
              FlatButton(
                onPressed: () => provider.loadCards(),
                child: Text('Try again'),
              ),
            ],
          );
        } else if (state is UnsplashStateSuccess) {
          final cards = state.cards;

          body = StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: cards.length,
            itemBuilder: (context, index) => _Image(card: cards[index]),
            staggeredTileBuilder: (index) => StaggeredTile.count(2, index.isEven ? 2 : 3),
          );
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: Text(state is UnsplashStateLoading ? 'Loading...' : 'Unsplash'),
            centerTitle: true,
            actions: [
              FlatButton(
                onPressed: () => provider.forceError(),
                child: Text(
                  'Force error',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          body: body,
        );
      },
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
    return Card(
      margin: EdgeInsets.all(6),
      clipBehavior: Clip.antiAlias,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: GestureDetector(
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
    );
  }
}
