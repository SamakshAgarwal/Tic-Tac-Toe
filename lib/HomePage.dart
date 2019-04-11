import 'package:flutter/material.dart';
import 'MultiPlayerGameLogic.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State with TickerProviderStateMixin {
  bool colorSelect = true;
  String player = 'Start game';
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          player.toUpperCase(),
          style: TextStyle(fontSize: 24),
        ),
        ButtonTheme(
          minWidth: double.minPositive,
          child: RaisedButton(
            onPressed: () {
              setState(() {
                MultiPlayerGameLogic().gameReset();
                player = 'Start Game';
              });
            },
            child: Icon(
              Icons.refresh,
              color: Colors.cyan,
            ),
            color: Colors.teal[50],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: AbsorbPointer(
            absorbing: MultiPlayerGameLogic().containerTouchDisabler(),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/background.png'))),
              margin: EdgeInsets.all(40),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
                child: _buildWidgets(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildWidgets() {
    List<Widget> widgList = new List<Widget>();
    for (var i = 0; i < 9; i++) {
      widgList.add(
        AbsorbPointer(
          absorbing: MultiPlayerGameLogic().absorbStatus(i),
          child: InkWell(
            onTap: () {
              setState(() {
                _controller.forward();
                player = MultiPlayerGameLogic().gameLogic(i);
              });
            },
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return GridTile(
                  child: Transform.translate(
                    child: Transform.translate(
                      child: Image.asset(
                        MultiPlayerGameLogic().imageProvider(i),
                        fit: BoxFit.scaleDown,
                      ),
                      offset: Offset(0, -1000),
                    ),
                    offset: Offset(0, 1000),
                  ),
                );
              },
            ),
          ),
        ),
      );
    }
    return new GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      shrinkWrap: true,
      children: widgList,
    );
  }
}
