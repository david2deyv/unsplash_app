import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:unsplash_app/helpers/pagination_trigger_mixin.dart';
import 'package:unsplash_app/json/cards.dart';
import 'package:unsplash_app/pagination_state.dart';
import 'package:unsplash_app/provider/unsplash_provider.dart';
import 'package:unsplash_app/screen/image_details.dart';
import 'package:unsplash_app/widgets/unsplash_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with PaginationTrigger {
  final ScrollController _scrollController = ScrollController();

  @override
  ScrollController get paginationScrollController => _scrollController;

  @override
  void onPaginationTriggered() {
    print('onPaginationTriggered');
    Provider.of<UnsplashProvider>(context, listen: false).loadNextPage();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UnsplashProvider>(
      builder: (context, provider, _) {
        final state = provider.state;
        List<UnsplashCard> data = [];
        Widget beforeData;
        Widget afterData;
        if (state is FirstPageLoading) {
          beforeData = Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
            ),
          );
        } else if (state is FirstPageError) {
          beforeData = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text(state.errorMessage)),
              FlatButton(
                onPressed: () => provider.loadFirst(),
                child: Text('Try again'),
              ),
            ],
          );
        } else if (state is FirstPage) {
          data = state.data;
        } else if (state is NextPageLoading) {
          data = state.data;
          afterData = Align(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
            ),
          );
        } else if (state is NextPage) {
          data = state.data;
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: Text(state is FirstPageLoading ? 'Loading...' : 'Unsplash'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              if (beforeData != null) beforeData,
              if (data?.isNotEmpty == true)
                Expanded(
                  child: StaggeredGridView.countBuilder(
                    key: ValueKey('photos'),
                    controller: _scrollController,
                    crossAxisCount: 4,
                    itemCount: data.length,
                    itemBuilder: (context, index) => _Image(
                      card: data[index],
                      fakeError: index != 0 && (index % 5) == 0,
                    ),
                    staggeredTileBuilder: (index) => StaggeredTile.count(2, index.isEven ? 2 : 3),
                  ),
                ),
              if (afterData != null) afterData,
            ],
          ),
        );
      },
    );
  }
}

class _Image extends StatefulWidget {
  const _Image({
    Key key,
    @required this.card,
    this.fakeError,
  }) : super(key: key);

  final UnsplashCard card;
  final bool fakeError;

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
        onTap: widget.fakeError == true
            ? null
            : () => Navigator.push(
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
                  fakeError: widget.fakeError,
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
