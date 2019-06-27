import 'dart:io';
import 'package:combustivel_ideal/helpers/posto_helper.dart';
import 'package:combustivel_ideal/model/posto.dart';
import 'package:flutter/material.dart';
import 'posto.dart';

class Lista extends StatefulWidget {
  final Posto posto;

  Lista({this.posto});

  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista>{

  PostoHelper helper = PostoHelper();

  List<Posto> lsPostos = List();

  void _requestPosto({Posto posto}){
      if (posto != null) {
        if (posto.id != null) {
          helper.update(posto);
        } else {
          helper.insert(posto);
        }
        _loadAllPostos();
      }
  }

    void _loadAllPostos(){
        helper.selectAll().then((list){
          setState((){
            lsPostos = list;
          });
        });
      }

   @override
   void initState(){
    super.initState();
      _requestPosto();
      //_loadAllPostos();
   }

  Widget buildAppBar(){
    return AppBar(
      title: Text("Lista de Postos"),
      backgroundColor: Colors.teal[300],
      centerTitle: true,
    );
  }

  Widget buildCardPosto(BuildContext context, int index){
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    lsPostos[index].nome ?? "-",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Cabin",
                      fontWeight: FontWeight.normal,
                    )
                  ),
                  Text(
                      lsPostos[index].alcool ?? "-",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: "Cabin",
                        fontWeight: FontWeight.normal,
                      )
                  ),
                  Text(
                      lsPostos[index].gasolina ?? "-",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: "Cabin",
                        fontWeight: FontWeight.normal,
                      )
                  ),
                  Text(
                      lsPostos[index].data ?? "-",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: "Cabin",
                        fontWeight: FontWeight.normal,
                      )
                  ),
                ],
              )
            )
          ],
        )
      ),
    );
  }

  Widget buildListView(){
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: lsPostos.length,
      itemBuilder: (context, index){
        return buildCardPosto(context, index);
      }
    );
  }

  Widget buildScaffold(){
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: buildListView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildScaffold();
  }

}