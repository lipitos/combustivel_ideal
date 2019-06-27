import 'dart:io';
import 'package:combustivel_ideal/model/posto.dart';
import 'package:combustivel_ideal/pages/lista.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';


class PostoPage extends StatefulWidget{


  final Posto posto;

  PostoPage({this.posto, Posto});

  @override
  _PostoPageState createState() =>_PostoPageState();
}

class _PostoPageState extends State<PostoPage>{

  String _melhor = "";
  String _dataAtualizada = "";
  double perc = 0;

  final _postoController = TextEditingController();
  final _alcoolController = TextEditingController();
  final _gasolinaController = TextEditingController();

  final _postoFocus = FocusNode();

  Posto _postoTemp;

  bool _postoEdited = false;

  void _resetFields(){
    _postoController.text = _postoTemp.nome = '';
    _alcoolController.text = '';
    _gasolinaController.text = '';
    perc = 0;
    _postoTemp.alcool = '';
    _postoTemp.gasolina = '';
  }

  void _verificar() {
    setState(() {
      double perc = double.parse(_postoTemp.alcool)/double.parse(_postoTemp.gasolina);
      if(perc >= 0.7){
          _melhor = 'gasolina';
      }else{
          _melhor = 'álcool';
      }
      _postoTemp.data = formatDate(DateTime.now(),
          [dd, '/', mm, '/', yyyy, ' as ', HH, ':', nn, ":", ss]).toString();
    });
  }

  void _showAlert(){
    AlertDialog dialog = AlertDialog(
      content: Text(
          'Para o abastecimento no posto "' +_postoTemp.nome+'", $_melhor é mais vantajoso',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15.0,
              fontFamily: "Cabin",
              fontWeight: FontWeight.normal,
          ),
      ),
      actions:
           <Widget>[
                  FlatButton(
                    onPressed: (){
                      if (_postoTemp.nome != null && _postoTemp.nome.isNotEmpty){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Lista(posto: _postoTemp)
                            ),
                        );
                      }
                      _resetFields();
                    },
                    child: Text("OK"),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 90.0, 0.0),
                  ),
                ],
          );
    showDialog(context: context, child: dialog);
  }

  Widget buildAppBar(){
    return AppBar(
      title: Text("Combustível Ideal",),
      backgroundColor: Colors.teal[300],
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.view_list),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Lista()
                ),
            );
          },
        ),
      ],
    );
  }

  Widget buildContainerImage(){
    return Container(
      width: 140.0,
      height: 140.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/posto.png")
        ),
      ),
    );
  }

  Widget buildScaffold(){
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
              buildContainerImage(),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Posto",
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: "Cabin",
                  fontWeight: FontWeight.normal,
                ),
                onChanged: (text){
                  _postoEdited = true;
                  setState((){
                    _postoTemp.nome = text;
                  });
                },
                controller: _postoController,
                focusNode: _postoFocus,
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Preço Álcool",
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: "Cabin",
                  fontWeight: FontWeight.normal,
                ),
                onChanged: (text){
                  _postoEdited = true;
                  setState((){
                    _postoTemp.alcool = text;
                  });
                },
                controller: _alcoolController,
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Preço Gasolina",
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: "Cabin",
                  fontWeight: FontWeight.normal,
                ),
                onChanged: (text){
                  _postoEdited = true;
                  setState((){
                    _postoTemp.gasolina = text;
                  });
                },
                controller: _gasolinaController,
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              RaisedButton(
                onPressed: () {
                    if (_postoTemp.nome != null && _postoTemp.nome.isNotEmpty){
                      _verificar();
                      _showAlert();
                    }else{
                      FocusScope.of(context).requestFocus(_postoFocus);
                    }
                  },
                padding: EdgeInsets.all(15.0),
                child: Text(
                    "Verificar",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Cabin",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )
                ),
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
                color: Colors.teal[300],
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildScaffold();
  }

  @override
  void initState(){
    super.initState();
    if(widget.posto == null){
      _postoTemp = Posto();
    }else{
      _postoTemp = Posto.fromMap(widget.posto.toMap());

      _postoController.text = _postoTemp.nome;
      _alcoolController.text = _postoTemp.alcool;
      _gasolinaController.text = _postoTemp.gasolina;
    }
  }

}
