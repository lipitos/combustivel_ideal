import 'package:combustivel_ideal/pages/posto.dart';
import 'package:flutter/material.dart';

class SplashHome extends StatefulWidget{
  @override
  _SplashHomeState createState() => _SplashHomeState();
}

class _SplashHomeState extends State<SplashHome>{

  String _versao = "1.0.0";

  @override
  void initState(){
    Future.delayed(Duration(seconds: 5)).then(( _ ){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => PostoPage())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            padding: EdgeInsets.only(left: 60.0, top: 30.0),
            child: Column(
              children:<Widget>[
                Text(
                  "Combustível Ideal",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: "Cabin",
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[300],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 110),
                ),
                Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/logo.png")
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: Container(
              color: Colors.teal[300],
              width: double.maxFinite,
              height: 50,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Versão $_versao",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: "Cabin",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ),
    );
  }
}