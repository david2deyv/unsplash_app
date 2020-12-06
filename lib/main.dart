import 'package:flutter/material.dart';
import 'services/services.dart';
import 'json/cards.dart';
import 'screen/page2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unsplash App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Cards> cards;
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
            Cards card = cards[index];
            return Padding(padding: EdgeInsets.all(3.0),
              child: Container(
                child: FittedBox(
                  child: Material(
                    color: Colors.grey[200],
                    elevation: 14.0,
                    shadowColor: Colors.grey[500],
                    child: Container(
                      decoration:  BoxDecoration(
                        borderRadius:  BorderRadius.all(Radius.circular(1.0)),
                        gradient:  LinearGradient(
                            colors: [Colors.grey, Colors.black54]
                        ),
                      ),
                      width: 200,
                      height: 50,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(1.0),
                            child: Center(
                              child: Container(
                                width: 80,
                                child: FlatButton(
                                  onPressed: () {
                                    Cards full = cards[index];
                                    Route route = MaterialPageRoute(builder: (context) => Page2(full: full));
                                    Navigator.push(context, route);
                                  },
                                  child: Image(
                                    image: NetworkImage(card.urls.regular),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5.0,),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(card.altDescription, style: TextStyle(fontSize: 7, color: Colors.white), textAlign: TextAlign.center),
                                  Text(card.user.username, style: TextStyle(fontSize: 7, color: Colors.white54, fontWeight: FontWeight.w700),),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



