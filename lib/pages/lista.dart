import 'package:combustivel_ideal/helpers/posto_helper.dart';
import 'package:combustivel_ideal/model/posto.dart';
import 'package:flutter/material.dart';


class Lista extends StatefulWidget {
  final Posto posto;

  Lista({this.posto});

  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista>{

  PostoHelper helper = PostoHelper();

  List<Posto> lsPostos = List();

  void _loadAllPostos(){
      helper.selectAll().then((list){
        setState((){
          lsPostos = list;
        });
      });
    }

  void _showAlert(int index){
    AlertDialog dialog = AlertDialog(
      content: Text(
        'Alerta! O registro será apagado',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontFamily: "Cabin",
          fontWeight: FontWeight.bold,
        ),
      ),
      actions:
      <Widget>[
        FlatButton(
          onPressed: (){
            _loadAllPostos();
            Navigator.pop(context);
          },
          child: Text("Cancelar"),
        ),
        FlatButton(
          onPressed: (){
            helper.delete(lsPostos[index].id);
            Navigator.pop(context);
          },
          child: Text("Continuar"),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 45.0, 0.0),
        ),
      ],
    );
    showDialog(context: context, child: dialog);
  }

   @override
   void initState(){
    super.initState();
      _loadAllPostos();
   }

  Widget buildAppBar(){
    return AppBar(
      title: Text("Lista de Postos"),
      backgroundColor: Colors.teal[300],
      centerTitle: true,
    );
  }

  Widget buildCardPosto(BuildContext context, int index){
    return Dismissible(
        key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
        background: Container(
          color: Colors.red,
          child: Align(
            alignment: Alignment(-0.9, 0.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
        direction: DismissDirection.startToEnd,
        child:Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Posto: " +
                          lsPostos[index].nome ?? "-",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "Cabin",
                            fontWeight: FontWeight.normal,
                          )
                        ),
                        Text("Preço Álcool: R\$" +
                            lsPostos[index].alcool ?? "-",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Cabin",
                              fontWeight: FontWeight.normal,
                            )
                        ),
                        Text("Preço Gasolina: R\$" +
                            lsPostos[index].gasolina ?? "-",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Cabin",
                              fontWeight: FontWeight.normal,
                            )
                        ),
                        Text("Cadastro realizado em " +
                            lsPostos[index].data ?? "-",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: "Cabin",
                              fontWeight: FontWeight.normal,
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),
        ),
        onDismissed: (direction){
          _showAlert(index);
        }
    );
  }

  Widget buildListView(){
    return ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: lsPostos.length,
        itemBuilder: (context, index){
          return buildCardPosto(context, index);
        },
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